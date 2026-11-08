"""Validate full coverage reports and compare semantic results with the original."""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
folder = ROOT / 'reports/coverage'
summary = json.loads((folder / 'summary.json').read_text())
cases = json.loads(Path(__file__).with_name('cases.json').read_text())
manifest = json.loads((folder / 'instrumentation.json').read_text())
release_hash = hashlib.sha256((ROOT / 'dist/UltimateFlashSonic.swf').read_bytes()).hexdigest()
assert summary['release_sha256'] == release_hash
assert manifest['movies']['rebuilt']['input_sha256'] == release_hash
assert len(summary['results']) == 2 * len(cases)

def semantic(traces):
    values = []
    for line in traces:
        if line.startswith(('STATE|', 'RECORD|', 'BOOT|')):
            continue
        if line.startswith('COMPANION|'):
            line = 'COMPANION|' + line.rsplit('|', 1)[1]
        values.append(line)
    return sorted(values)

comparisons = {}
for case in cases:
    name = case['name']
    pair = {}
    for version in ['original', 'rebuilt']:
        report = json.loads((folder / version / name / 'runtime.json').read_text())
        assert report['sha256'] == manifest['movies'][version]['instrumented_sha256'], (version, name, 'wrong fixture')
        assert not report['errors'], (version, name, report['errors'])
        result = summary['results'][version + '/' + name]
        assert result['passed'], (version, name, result)
        pair[version] = report['traces']
    if name == 'boss-1':
        assert 'FAIL|timeout|boss-outro' in pair['original']
        assert 'OUTRO' in pair['rebuilt']
        assert any(t.startswith('TRANSITION|2|1|off|21') for t in pair['rebuilt'])
        comparisons[name] = 'Original softlock reproduced; rebuilt game completes normally'
    else:
        assert semantic(pair['original']) == semantic(pair['rebuilt']), (name, pair)
        comparisons[name] = 'Matches original'
    if name == 'time-trial':
        for version, traces in pair.items():
            record = next(t for t in traces if t.startswith('RECORD|'))
            assert '9:59:99' not in record and record.endswith('|sonic'), (version, record)
    if name == 'death-restart':
        assert any(t.startswith('TRANSITION|') and t.endswith('|2') for t in pair['rebuilt'])

result = {'release_sha256': release_hash, 'cases_per_version': len(cases),
          'runtime_runs': len(cases) * 2, 'unexpected_failures': 0,
          'startup_retries': sum(len(json.loads(p.read_text()).get('startupRetries', [])) for p in folder.glob('*/*/runtime.json')),
          'comparisons': comparisons,
          'method': 'State-driven integration fixtures with original collision, damage, transition, ending and menu handlers. Not an unaided keyboard playthrough.'}
(folder / 'comparison.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
