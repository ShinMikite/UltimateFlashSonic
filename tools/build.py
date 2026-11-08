"""Compile every extracted AVM1 script into the archived timeline and assets."""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--ffdec', required=True, type=Path)
    parser.add_argument('--output', type=Path, default=ROOT / 'dist/UltimateFlashSonic.swf')
    args = parser.parse_args()
    command = ['java', '-Xmx4g', '-jar', str(args.ffdec.resolve())]
    source = ROOT / 'source'
    original = ET.parse(source / 'UltimateFlashSonic.swf.xml')
    skeleton = copy.deepcopy(original)
    actions = [e for e in skeleton.iter() if 'actionBytes' in e.attrib]
    scripts = list((source / 'scripts').rglob('*.as'))
    if len(actions) != 419 or len(scripts) != len(actions):
        raise ValueError('Expected exactly 419 scripts and action records')
    # Remove the archived bytecode so a missing import cannot silently pass.
    for element in actions:
        element.set('actionBytes', '00')
    with tempfile.TemporaryDirectory(prefix='sonic-build-') as directory:
        temp = Path(directory)
        skeleton.write(temp / 'skeleton.xml', encoding='utf-8', xml_declaration=True)
        def run(*arguments):
            subprocess.run(command + list(map(str, arguments)), check=True)
        run('-xml2swf', temp / 'skeleton.xml', temp / 'skeleton.swf')
        run('-onerror', 'abort', '-importScript', temp / 'skeleton.swf', temp / 'compiled.swf', source)
        run('-swf2xml', temp / 'compiled.swf', temp / 'compiled.xml')
        compiled = ET.parse(temp / 'compiled.xml')
        old_nodes, new_nodes = list(original.iter()), list(compiled.iter())
        if len(old_nodes) != len(new_nodes):
            raise ValueError('Compiler changed the timeline structure')
        count = 0
        restored_events = 0
        for old, new in zip(old_nodes, new_nodes):
            if old.tag != new.tag or old.get('type') != new.get('type'):
                raise ValueError('Compiler changed tag ordering')
            if 'actionBytes' in old.attrib:
                bytecode = new.get('actionBytes')
                if not bytecode or bytecode == '00':
                    raise ValueError(f'Script {count + 1} was not compiled')
                # The source syntax cannot express every legacy button event flag.
                # Preserve all timeline/event metadata and replace only compiled code.
                restored_events += sum(old.get(k) != new.get(k) for k in old.attrib if k.startswith('cond'))
                old.set('actionBytes', bytecode)
                count += 1
        original.write(temp / 'final.xml', encoding='utf-8', xml_declaration=True)
        args.output.parent.mkdir(parents=True, exist_ok=True)
        run('-xml2swf', temp / 'final.xml', args.output.resolve())
    report = {
        'compiler': 'JPEXS Free Flash Decompiler 26.4.0',
        'scripts_compiled': count,
        'original_bytecode_removed_before_compilation': True,
        'legacy_button_event_flags_preserved': restored_events,
        'output': args.output.name,
        'sha256': hashlib.sha256(args.output.read_bytes()).hexdigest()
    }
    (ROOT / 'reports').mkdir(exist_ok=True)
    (ROOT / 'reports/build.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
