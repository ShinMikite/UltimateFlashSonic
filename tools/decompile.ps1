param(
    [Parameter(Mandatory = $true)][string]$FFDecJar,
    [string]$OutputDirectory = 'source'
)
$ErrorActionPreference = 'Stop'
$FFDecJar = (Resolve-Path -LiteralPath $FFDecJar).Path
$root = Split-Path $PSScriptRoot -Parent
Push-Location $root
try {
    $inputFile = '151706_ultimate_sonic202c.swf'
    $expected = 'A54D2C0748852907F3F9A2D8C4DA12261762BEFC14F5EEF65100622B4B7B00D9'
    if ((Get-FileHash $inputFile -Algorithm SHA256).Hash -ne $expected) {
        throw 'The input SWF does not match the archived original.'
    }
    New-Item -ItemType Directory -Force $OutputDirectory | Out-Null
    & java -Xmx4g -jar $FFDecJar -onerror abort -export 'script,image,shape,morphshape,movie,font,font4,sound,binaryData,symbolClass,text' $OutputDirectory $inputFile
    if ($LASTEXITCODE -ne 0) { throw 'Resource export failed.' }
    & java -Xmx4g -jar $FFDecJar -onerror abort -format xfl:cs6 -export xfl (Join-Path $OutputDirectory 'flash') $inputFile
    if ($LASTEXITCODE -ne 0) { throw 'Flash project export failed.' }
    $exported = Join-Path $OutputDirectory 'flash/151706_ultimate_sonic202c'
    $named = Join-Path $OutputDirectory 'flash/UltimateFlashSonic'
    if ((Test-Path -LiteralPath $exported) -and !(Test-Path -LiteralPath $named)) {
        Rename-Item -LiteralPath $exported -NewName 'UltimateFlashSonic'
    }
    & java -Xmx4g -jar $FFDecJar -swf2xml $inputFile (Join-Path $OutputDirectory 'UltimateFlashSonic.swf.xml')
    if ($LASTEXITCODE -ne 0) { throw 'SWF XML export failed.' }
} finally {
    Pop-Location
}
