$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/jendrikseipp/rednotebook/releases/download/v2.7/rednotebook-2.7.exe'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  softwareName  = 'RedNotebook*'
  checksum      = 'C5602612516422E4AA5B95959582BF997623A9BBDCA7ED685AB6C977D639A370'
  checksumType  = 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
  validExitCodes= @(0)
}
Install-ChocolateyPackage @packageArgs
