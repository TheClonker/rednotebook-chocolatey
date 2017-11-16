$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/jendrikseipp/rednotebook/releases/download/v2.3/rednotebook-2.3.exe'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  softwareName  = 'RedNotebook*'
  checksum      = '8C7FE73EA09628F7E976A62171147FE798D44AA516DA6B1F8873E4572A7ADA63'
  checksumType  = 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
  validExitCodes= @(0)
}
Install-ChocolateyPackage @packageArgs
