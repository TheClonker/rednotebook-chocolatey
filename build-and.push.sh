#!/usr/bin/env bash
# Build a .nuspec File for RedNotebook and Push it to Chocolatey

set -o errexit
set -o pipefail
set -o nounset

# Download file and compute SHA256 Checksum
curl --location $URL --silent --output tmpfile
CHECKSUM=$(sha256sum tmpfile | awk '{print $1}')
rm tmpfile

echo "Version: $VERSION"
echo "URL: $URL"
echo "Checksum: $CHECKSUM"
echo "Release Notes: $RELEASENOTES"

# Replace Variables
sed -i "s/%%VERSION%%/$VERSION/" rednotebook.nuspec
sed -i "s/%%RELEASENOTES%%/Release Notes:\n$RELEASENOTES/" rednotebook.nuspec
sed -i "s~%%URL%%~$URL~" tools/chocolateyinstall.ps1
sed -i "s/%%CHECKSUM%%/$CHECKSUM/" tools/chocolateyinstall.ps1

# Build the .nupkg File
choco pack

# Set API Key and Push
choco apikey -k $CHOCO_API_KEY -source https://push.chocolatey.org/
#choco push *.nupkg -s https://push.chocolatey.org/
ls -la