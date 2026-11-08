"""Run every coverage fixture against the original and rebuilt game."""
import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[2]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('dependencies', type=Path)
parser.add_argument('--filter', default='')
parser.add_argument('--reuse-existing', action='store_true')
args = parser.parse_args()
cases = json.loads(Path(__file__).with_name('cases.json').read_text())
jobs = [(version, case) for version in ['original', 'rebuilt'] for case in cases
        if not args.filter or args.filter in case['name']]

def run(version, case):
    name = version + '/' + case['name']
    destination = ROOT / 'reports/coverage' / name
    destination.mkdir(parents=True, exist_ok=True)
    config = ROOT / 'build/coverage' / (version + '-' + case['name'] + '.json')
    # Each worker owns its scenario file.
    config.write_text(json.dumps(case))
    log = ROOT / 'build/coverage' / (version + '-' + case['name'] + '.log')
    current_report = destination / 'runtime.json'
    cached = json.loads(current_report.read_text()) if current_report.exists() else {}
    fixture_hash = hashlib.sha256((ROOT/'build/coverage'/(version+'.swf')).read_bytes()).hexdigest()
    if args.reuse_existing and cached.get('sha256') == fixture_hash and cached.get('steps') == case['steps'] and not cached.get('errors'):
        result = subprocess.CompletedProcess([], 1 if any(t.startswith('FAIL|') for t in cached.get('traces', [])) else 0)
    else:
        (destination / 'runtime.json').unlink(missing_ok=True)
        with log.open('w') as stream:
            result = subprocess.run(['node', str(Path(__file__).with_name('run-case.cjs')),
                str(args.dependencies.resolve()), str(ROOT/'build/coverage'/(version+'.swf')),
                str(config), str(destination)], stdout=stream, stderr=subprocess.STDOUT, timeout=110)
    report = destination / 'runtime.json'
    if not report.exists():
        return name, {'passed': False, 'reason': 'No runtime report', 'exit_code': result.returncode}
    data = json.loads(report.read_text())
    traces = data['traces']
    failures = [t for t in traces if t.startswith('FAIL|')]
    known = version == 'original' and case['name'] == 'boss-1' and 'FAIL|timeout|boss-outro' in failures
    checks = ['DONE' in traces, not data['errors']]
    kind = case['parameters']['testKind']
    if kind == 'level':
        checks += [any(t.startswith('TILES|') for t in traces), 'FINISH_SIGN|on' in traces,
                   'OUTRO' in traces, any(t.startswith('TRANSITION|') for t in traces)]
    if kind == 'level' and case['parameters'].get('testMode') != 'timetrial':
        z=int(case['parameters']['testZone']);a=int(case['parameters']['testAct'])
        prefix=f"TRANSITION|{z}|{2 if a==1 else 1}|{'off' if a==1 else 'on'}|"
        checks += [any(t.startswith(prefix) and t.endswith('|3') for t in traces)]
    if kind == 'boss':
        checks += [all('HIT|'+str(i) in traces for i in range(10)), 'DEFEATED' in traces]
        if not known:
            checks += ['OUTRO' in traces, any(t.startswith('TRANSITION|') for t in traces)]
    if kind == 'unlocks':
        checks += [any(t.startswith('UNLOCK|cream|1|0|0|1|1|1|1|0|') for t in traces),
                   any(t.startswith('UNLOCK|amy|1|1|1|1|1|1|1|1|') for t in traces)]
    if kind == 'menu':
        checks += ['PASSWORD|accepted|595313131313131|1|1|1' in traces,
                   'INVALID|invalid passwd|595313131313131' in traces,
                   'EASTER_EGG|movieclip' in traces,
                   all('TOGGLE|'+str(i)+'|2' in traces and 'TOGGLE_OFF|'+str(i)+'|1' in traces for i in range(1,6))]
    if kind == 'cheat':
        effect = next((t.split('|') for t in traces if t.startswith('EFFECT|')), [])
        i = int(case['parameters']['testCheat'])
        checks += [bool(effect)]
        if effect:
            checks += [{1: effect[2]=='43', 2: effect[3]=='movieclip', 3: effect[4]=='-1',
                        4: any(t.startswith('COMPANION|') and t.endswith('|300') for t in traces),
                        5: effect[6:8]==['0.25','0.05'], 6: effect[8]=='2'}[i]]
    if kind == 'death':
        checks += ['GAMEOVER' in traces if case['name']=='game-over' else any(t.startswith('TRANSITION|') for t in traces)]
    if case['name']=='unlock-amy-ending': checks += [any('NEW CHARACTER: Amy Rose' in t for t in traces)]
    if case['name']=='ending-amy': checks += [any('NEW CHARACTER: Shadow' in t and 'JUKEBOX unlocked' in t for t in traces)]
    if case['name']=='ending-shadow': checks += [any('whole game' in t for t in traces)]
    return name, {'passed': all(checks) and (not failures or known), 'known_original_defect': known,
                  'traces': traces, 'errors': data['errors'], 'exit_code': result.returncode}

results = {}
with ThreadPoolExecutor(max_workers=3) as pool:
    futures = [pool.submit(run, version, case) for version, case in jobs]
    for future in as_completed(futures):
        name, result = future.result()
        results[name] = result
        print(name, 'PASS' if result['passed'] else 'FAIL', flush=True)
summary = {'release_sha256': hashlib.sha256((ROOT/'dist/UltimateFlashSonic.swf').read_bytes()).hexdigest(),
           'fixture': 'Original gameplay bytecode retained; test entry, telemetry and state setup added only to temporary SWFs.',
           'results': dict(sorted(results.items()))}
report = ROOT / 'reports/coverage' / ('summary'+('-'+args.filter if args.filter else '')+'.json')
report.write_text(json.dumps(summary, indent=2)+'\n')
if not all(result['passed'] for result in results.values()): raise SystemExit(1)
