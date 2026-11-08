"""Check the recorded playtest screenshots and browser reports (requires Pillow)."""
import hashlib
import json
from pathlib import Path
from PIL import Image, ImageChops

ROOT = Path(__file__).resolve().parents[1]
output = ROOT / 'reports/runtime'
results = {}
for name in ['original', 'sonic', 'tails', 'knuckles', 'cream']:
    folder = output / name
    report = json.loads((folder / 'runtime.json').read_text())
    movie = ROOT / ('151706_ultimate_sonic202c.swf' if name == 'original' else 'dist/UltimateFlashSonic.swf')
    if report['errors'] or report['sha256'] != hashlib.sha256(movie.read_bytes()).hexdigest():
        raise ValueError(f'{name}: browser errors or wrong build')
    shots = {s['shot']: Image.open(folder / (s['shot'] + '.png')).convert('RGB')
             for s in report['steps'] if 'shot' in s}
    for key, shot in shots.items():
        if shot.size != (700, 500) or len(shot.getcolors(350001)) < 100:
            raise ValueError(f'{name}: blank or invalid screenshot {key}')
    timer = (280, 15, 450, 48)
    if ImageChops.difference(shots['paused'].crop(timer), shots['paused-still'].crop(timer)).getbbox():
        raise ValueError(f'{name}: timer advanced while paused')
    for a, b in [('gameplay-start', 'running'), ('running', 'jumping'), ('paused-still', 'resumed')]:
        if not ImageChops.difference(shots[a], shots[b]).getbbox():
            raise ValueError(f'{name}: no visible response between {a} and {b}')
    r, g, b = shots['paused-still'].getpixel((230, 270))
    if not (r > 200 and 80 < g < 220 and b < 80):
        raise ValueError(f'{name}: pause menu missing')
    results[name] = {'browser_errors': 0, 'screenshots_checked': len(shots),
                     'pause_timer_stable': True, 'input_responses_visible': True}
summary = {'runtime': 'Ruffle 0.7.1 in Google Chrome', 'results': results,
           'scope': 'Opening menus, four starting characters, first-level movement, jumping, spindash, pause and resume. Original Sonic run used as reference.',
           'limitations': 'Not a complete playthrough; later levels, bosses, unlockables, audio fidelity and Flash CS6 publishing are not verified.'}
(output / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
print(json.dumps(summary, indent=2))
