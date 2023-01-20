#!/usr/bin/env bash
# Build a .nuspec File for RedNotebook and Push it to Chocolatey

set -o errexit
set -o pipefail
set -o nounset

# Download file and compute SHA256 Checksum
curl --location $URL --silent --output tmpfile
CHECKSUM=$(sha256sum tmpfile | awk '{print $1}')
rm tmpfile

# Replace Variables
echo "Version: $VERSION"
sed -i "s/%%VERSION%%/$VERSION/" rednotebook.nuspec
echo "Release Notes:"
echo "$RELEASENOTES"
# Perl is easier for multiline than sed, supposedly
perl -0777 -i -pe "s|%%RELEASENOTES%%|Release Notes:\n$RELEASENOTES|" rednotebook.nuspec
echo "URL: $URL"
sed -i "s~%%URL%%~$URL~" tools/chocolateyinstall.ps1
echo "Checksum: $CHECKSUM"
sed -i "s/%%CHECKSUM%%/$CHECKSUM/" tools/chocolateyinstall.ps1

# Build the .nupkg File
choco pack

# Set API Key and Push
choco apikey -k $CHOCO_API_KEY -source https://push.chocolatey.org/
choco push *.nupkg -s https://push.chocolatey.org/
