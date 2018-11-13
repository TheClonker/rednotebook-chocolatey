$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/jendrikseipp/rednotebook/releases/download/v2.7.1/rednotebook-2.7.1.exe'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  softwareName  = 'RedNotebook*'
  checksum      = '3A16BAAAE4F577AE5351F50C9DE0EE2146FE909D5D47B79EAF90214FEEBE252C'
  checksumType  = 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
  validExitCodes= @(0)
}
Install-ChocolateyPackage @packageArgs
