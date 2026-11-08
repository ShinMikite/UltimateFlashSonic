"""Verify the archive, exported XML, and SWF XML round trip."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
EXPECTED = 'a54d2c0748852907f3f9a2d8c4da12261762befc14f5eef65100622b4b7b00d9'
# FFDec recomputes these storage widths when serializing unchanged geometry.
STORAGE_WIDTHS = {'numFillBits', 'nbits', 'moveBits', 'nScaleBits'}


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def compare(a, b, changes):
    if a.tag != b.tag or len(a) != len(b):
        raise ValueError('XML structure changed')
    if (a.text or '').strip() != (b.text or '').strip():
        raise ValueError('XML text changed')
    for key in set(a.attrib) | set(b.attrib):
        if a.get(key) != b.get(key):
            if key not in STORAGE_WIDTHS:
                raise ValueError(f'Unexpected attribute difference: {key}')
            changes[key] += 1
    for left, right in zip(a, b):
        compare(left, right, changes)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--ffdec', required=True, type=Path)
    parser.add_argument('--source', type=Path, default=ROOT / 'source')
    parser.add_argument('--report', type=Path, default=ROOT / 'reports/verification.json')
    args = parser.parse_args()
    original = ROOT / '151706_ultimate_sonic202c.swf'
    if sha256(original) != EXPECTED:
        raise ValueError('Original SWF checksum mismatch')
    source = args.source.resolve()
    xml = source / 'UltimateFlashSonic.swf.xml'
    tree = ET.parse(xml).getroot()
    xml_files = list((source / 'flash').rglob('*.xml'))
    if not xml_files or not list((source / 'flash').rglob('*.xfl')):
        raise ValueError('Flash project missing')
    for path in xml_files:
        ET.parse(path)
    counts = {p.name: sum(1 for f in p.rglob('*') if f.is_file())
              for p in sorted(source.iterdir()) if p.is_dir()}
    if counts.get('scripts') != 419:
        raise ValueError('Expected 419 script exports')
    changes = Counter()
    with tempfile.TemporaryDirectory(prefix='sonic-verify-') as temporary:
        rebuilt = Path(temporary) / 'rebuilt.swf'
        reexported = Path(temporary) / 'rebuilt.xml'
        command = ['java', '-Xmx4g', '-jar', str(args.ffdec.resolve())]
        subprocess.run(command + ['-xml2swf', str(xml), str(rebuilt)], check=True)
        subprocess.run(command + ['-swf2xml', str(rebuilt), str(reexported)], check=True)
        compare(tree, ET.parse(reexported).getroot(), changes)
        rebuilt_hash = sha256(rebuilt)
    report = {
        'tool': 'JPEXS Free Flash Decompiler 26.4.0',
        'original_sha256': EXPECTED,
        'rebuilt_sha256': rebuilt_hash,
        'byte_identical': EXPECTED == rebuilt_hash,
        'xml_roundtrip': 'Equivalent except for recomputed storage bit widths',
        'storage_width_changes': dict(changes),
        'xfl_xml_files_parsed': len(xml_files),
        'export_file_counts': counts,
        'runtime_playtest': 'See reports/runtime/summary.json for compiled-game playtests',
        'xfl_publish_test': 'Not performed'
    }
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
