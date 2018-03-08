$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/jendrikseipp/rednotebook/releases/download/v2.4/rednotebook-2.4.exe'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  softwareName  = 'RedNotebook*'
  checksum      = '0190011BFB8DE2E0ADA0B43C14B6799CC572E0910AFEA55EF02C95EE448A0833'
  checksumType  = 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
  validExitCodes= @(0)
}
Install-ChocolateyPackage @packageArgs
