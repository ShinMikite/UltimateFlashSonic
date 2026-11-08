"""Inject fixtures without recompiling original gameplay action payloads."""
import argparse, hashlib, json, subprocess, tempfile
from pathlib import Path
import xml.etree.ElementTree as E
ROOT=Path(__file__).resolve().parents[2]
p=argparse.ArgumentParser();p.add_argument('--ffdec',required=True);args=p.parse_args()
cmd=['java','-Xmx4g','-jar',args.ffdec]
def run(*a):subprocess.run(cmd+list(map(str,a)),check=True)
def locate(tree):
 result={};frame=1
 for item in tree.getroot().find('tags'):
  if item.get('type')=='DoActionTag' and frame in [1,2,290,342]:result[str(frame)]=item
  if item.get('type')=='PlaceObject2Tag' and item.get('characterId')=='2556':
   for record in item.findall('./clipActions/clipActionRecords/item'):
    if record.find('eventFlags').get('clipEventEnterFrame')=='true':result['tick']=record
  if item.get('type')=='ShowFrameTag':frame+=1
 for item in tree.getroot().find('tags'):
  if item.get('type')=='DefineSpriteTag' and item.get('spriteId')=='146':
   result['ending']=next(e for e in item.find('subTags') if e.get('type')=='DoActionTag')
  if item.get('type')=='PlaceObject2Tag' and item.get('characterId')=='2497':
   for record in item.findall('./clipActions/clipActionRecords/item'):
    if record.find('eventFlags').get('clipEventEnterFrame')=='true':result['menu']=record
 for item in tree.getroot().find('tags'):
  if item.get('type')=='PlaceObject2Tag' and item.get('characterId')=='2551':
   for record in item.findall('./clipActions/clipActionRecords/item'):
    if record.find('eventFlags').get('clipEventEnterFrame')=='true':result['leveltick']=record
 for item in tree.getroot().find('tags'):
  if item.get('type')=='PlaceObject2Tag' and item.get('characterId')=='2500':
   for record in item.findall('./clipActions/clipActionRecords/item'):
    if record.find('eventFlags').get('clipEventEnterFrame')=='true':result['menuguard']=record
 return result
out=ROOT/'build/coverage';out.mkdir(parents=True,exist_ok=True)
with tempfile.TemporaryDirectory(prefix='sonic-fixture-') as directory:
 d=Path(directory)
 for path,code in [('DefineSprite_146_End/frame_1/DoAction.as','trace("ENDING|"+messagefin);'),('frame_291/PlaceObject2_2497_4/CLIPACTIONRECORD onClipEvent(enterFrame).as','onClipEvent(enterFrame){ _root.testMenuStep(); }'),('frame_327/PlaceObject2_2551_17/CLIPACTIONRECORD onClipEvent(enterFrame).as','onClipEvent(enterFrame){ if(_root.testKind == "cheat") _root.testStep(); }'),('frame_291/PlaceObject2_2500_41/CLIPACTIONRECORD onClipEvent(enterFrame).as','onClipEvent(enterFrame){ if(_root.testKind != "menu") return; }'),('frame_1/DoAction.as','play();'),('frame_2/DoAction.as','if(_framesloaded < _totalframes){gotoAndPlay(1);return;}'),('frame_342/DoAction.as','trace("TRANSITION|"+_root.czone+"|"+_root.cact+"|"+_root.boss+"|"+_root.save[_root.chara]+"|"+_root.lives);trace("RECORD|"+_root.record["1-1"]+"|"+_root.record["1-1-char"]);trace("DONE");'),('frame_290/DoAction.as',Path(__file__).with_name('driver.as').read_text()),('frame_327/PlaceObject2_2556_25/CLIPACTIONRECORD onClipEvent(enterFrame).as','onClipEvent(enterFrame){ if(_root.testKind != "cheat") _root.testStep(); }')]:
  f=d/'scripts'/path;f.parent.mkdir(parents=True,exist_ok=True);f.write_text(code)
 run('-importScript',ROOT/'dist/UltimateFlashSonic.swf',d/'fixture.swf',d)
 run('-swf2xml',d/'fixture.swf',d/'fixture.xml')
 fixture=locate(E.parse(d/'fixture.xml'))
 for name,source in [('original',ROOT/'151706_ultimate_sonic202c.swf'),('rebuilt',ROOT/'dist/UltimateFlashSonic.swf')]:
  run('-swf2xml',source,d/'input.xml');tree=E.parse(d/'input.xml');targets=locate(tree)
  assert len(targets)==9, 'Missing fixture action records'
  initialization=targets['290'].get('actionBytes')[:-2]+fixture['290'].get('actionBytes')
  for key,target in targets.items():
   if key=='290': continue
   if key=='1':
    target.set('actionBytes',fixture['1'].get('actionBytes'))
    continue
   if key=='2':
    target.set('actionBytes',fixture['2'].get('actionBytes')[:-2]+initialization)
    continue
   code=fixture[key].get('actionBytes')
   if key not in ['1','2']:
    assert target.get('actionBytes').endswith('00'), 'Expected action terminator'
    code=(code[:-2]+target.get('actionBytes')) if key=='menuguard' else (target.get('actionBytes')[:-2]+code)
   target.set('actionBytes',code)
  tree.write(d/'instrumented.xml',encoding='utf-8',xml_declaration=True)
  run('-xml2swf',d/'instrumented.xml',out/(name+'.swf'))
  print(name,hashlib.sha256((out/(name+'.swf')).read_bytes()).hexdigest())

manifest={'driver_sha256':hashlib.sha256(Path(__file__).with_name('driver.as').read_bytes()).hexdigest(),
          'actions_replaced':['preloader frame 1 plays','preloader frame 2 waits for all frames, then runs original initialization plus fixture startup'],
          'actions_extended':['player frame tick','level frame tick','menu frame tick','completion','ending'],
          'guards':['menu character transition disabled for direct stage fixtures'],
          'movies':{}}
for name,source in [('original',ROOT/'151706_ultimate_sonic202c.swf'),('rebuilt',ROOT/'dist/UltimateFlashSonic.swf')]:
 manifest['movies'][name]={'input_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
                          'instrumented_sha256':hashlib.sha256((out/(name+'.swf')).read_bytes()).hexdigest()}
report=ROOT/'reports/coverage/instrumentation.json'
report.parent.mkdir(parents=True,exist_ok=True)
report.write_text(json.dumps(manifest,indent=2)+'\n')
