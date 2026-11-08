# Ultimate Flash Sonic

Decompiled source and assets from `151706_ultimate_sonic202c.swf`.
The original SWF is preserved unchanged. It targets Flash 5, uses AVM1
ActionScript, and has a 350 × 250 stage at 35 FPS with 359 root timeline frames.

## Contents

| Path | Contents |
| --- | --- |
| `source/scripts/` | 419 ActionScript files, organized by timeline, symbol and event |
| `source/images/` | 859 bitmap assets |
| `source/shapes/` | 1,256 SVG vector shapes |
| `source/morphshapes/` | 14 morph shape exports |
| `source/sounds/` | 38 audio files |
| `source/fonts/` | 5 font files |
| `source/texts/` | 88 text exports |
| `source/symbolClass/symbols.csv` | Original symbol linkage names and IDs |
| `source/flash/UltimateFlashSonic/` | Reconstructed Flash CS6 XFL project |
| `source/UltimateFlashSonic.swf.xml` | Full SWF structure, including timelines and action bytecode |
| `reports/verification.json` | Export inventory and structural verification results |
| `dist/UltimateFlashSonic.swf` | Game rebuilt from XML assets and compiled ActionScript |
| `reports/build.json` | Compiler, script count and output checksum |

Open `source/flash/UltimateFlashSonic/151706_ultimate_sonic202c.xfl` in
Flash Professional CS6 to inspect the reconstructed authoring project. Keep its
`LIBRARY`, `bin`, and XML files together. Publishing this legacy ActionScript
requires a Flash authoring version that supports AVM1.

## Source map

- `source/scripts/frame_290/DoAction.as`: password generation and cheat setup.
- `source/scripts/frame_291/`: main menu, character selection, options and audio.
- `source/scripts/frame_314/`: level selection events.
- `source/scripts/frame_327/PlaceObject2_2556_25/`: player controls, movement,
  gravity, animation, grinding and ring loss.
- `source/scripts/frame_327/PlaceObject2_2551_17/`: level and object setup.
- `source/scripts/DefineSprite_*/`: individual sprite timelines and events.

Frame numbers in the exported directory names are one-based. Numeric symbol IDs
connect scripts to artwork and the SWF XML. Decompiled scripts retain recovered
names and syntax; comments and original authoring organization cannot be restored.
The `.as` files alone are not a standalone build: timeline placement and symbol
linkage are part of the game.

## Reproduce the extraction

Install Java and download the portable ZIP of
[JPEXS Free Flash Decompiler 26.4.0](https://github.com/jindrapetrik/jpexs-decompiler/releases/tag/version26.4.0)
outside this repository. From PowerShell:

```powershell
./tools/decompile.ps1 -FFDecJar 'C:/Tools/ffdec/ffdec.jar' -OutputDirectory 'build/extracted'
python ./tools/verify.py --ffdec 'C:/Tools/ffdec/ffdec.jar' --source 'build/extracted' --report 'build/verification.json'
```

The export script follows the [FFDec command-line interface](https://github.com/jindrapetrik/jpexs-decompiler/wiki/Commandline-arguments).
Use a fresh output directory when comparing exports to avoid stale files.
Python 3 is only needed for verification.

## Compile the game

The supported build uses FFDec's AVM1 compiler and does not require Flash CS6:

```powershell
python tools/build.py --ffdec 'C:/Tools/ffdec/ffdec.jar'
```

This creates `dist/UltimateFlashSonic.swf`. All 419 archived action records are
emptied before compilation; the build fails if any script is left empty. Assets
and timelines come from the SWF XML, and executable code comes from the `.as`
files. Edit those files to change gameplay. The XFL project is an additional
authoring export and is not the input to this build.

FFDec's script import drops one legacy button transition flag. The build restores
the original event metadata when assembling the compiled code, preserving that
button's release behavior.

To rebuild only the archived SWF XML without compiling scripts:

```powershell
New-Item -ItemType Directory -Force build
java -jar 'C:/Tools/ffdec/ffdec.jar' -xml2swf source/UltimateFlashSonic.swf.xml build/UltimateFlashSonic.swf
```

## Verification and limitations

The original SHA-256 is
`a54d2c0748852907f3f9a2d8c4da12261762befc14f5eef65100622b4b7b00d9`.
Verification parses all reconstructed XFL XML files and performs an XML → SWF → XML
round trip. The reexported structure matches except for recomputed geometry bit
width fields; the rebuilt SWF is not byte-identical to the original.
The XFL project has not been published in Flash CS6. This is a reconstruction,
not the original authoring project. Runtime test results for the compiled SWF
are recorded separately in `reports/runtime/`.

## Runtime tests

Install the browser test dependencies outside the repository:

```powershell
npm install --prefix C:/Tools/flash-runtime playwright @ruffle-rs/ruffle@0.7.1
node tools/runtime-test.cjs C:/Tools/flash-runtime dist/UltimateFlashSonic.swf tools/scenarios/sonic.json build/runtime
```

The harness uses installed Google Chrome in headless mode, serves the game on a
temporary loopback-only HTTP port, runs the recorded mouse and keyboard inputs,
and saves screenshots and browser errors. Run each of the four scenarios into
`reports/runtime/<character>` and run the Sonic scenario against the original SWF
into `reports/runtime/original`. Then install Pillow (`python -m pip install Pillow`)
and run `python tools/verify-runtime.py` to check the recorded builds, screenshots,
pause timer and visible input responses.

The recorded runs passed for Sonic, Tails, Knuckles and Cream, with no browser
errors. The original Sonic run provides a visual reference. Checks cover initial
menus and first-level movement, jumping, spindash, pause and resume. They do not
constitute a full playthrough, and audio fidelity has not been checked. Ruffle is an emulator; passing these
tests does not establish compatibility with every historic Flash Player version
or complete coverage of every level and unlockable.

Original game credits and embedded assets are preserved. This repository does not
grant new rights to third-party code, characters, music or artwork.
