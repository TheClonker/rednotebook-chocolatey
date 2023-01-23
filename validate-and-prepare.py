#!/usr/bin/env python

import hashlib
import xml.etree.ElementTree as ET
from os import getenv
from urllib.request import urlopen

url = getenv('URL', '')
version = getenv('VERSION', '')
releaseNotes = getenv('RELEASENOTES', '')
checksum = ''

if url == '':
  raise ValueError('URL Environment Variable not set')
if version == '':
  raise ValueError('VERSION Environment Variable not set')
if releaseNotes == '':
  raise ValueError('RELEASENOTES Environment Variable not set')

print(f'VERSION: {version}')
print(f'URL: {url}')
print(f'Release Notes:\n{releaseNotes}')

# Constants
NUSPEC_FILEPATH = 'rednotebook.nuspec'
CHOCOLATEYINSTALL_FILEPATH = 'tools/chocolateyinstall.ps1'
NS = 'http://schemas.microsoft.com/packaging/2015/06/nuspec.xsd'
ET.register_namespace('', NS)

# Update nuspec XML File
tree = ET.parse(NUSPEC_FILEPATH)
root = tree.getroot()

versionNode = tree.find(f'{{{NS}}}metadata/{{{NS}}}version')
versionNode.text = version

releaseNotesNode = tree.find(f'{{{NS}}}metadata/{{{NS}}}releaseNotes')
releaseNotesNode.text = releaseNotes

with open(NUSPEC_FILEPATH, 'wb') as f:
  tree.write(f, encoding='utf-8', xml_declaration=True)

# Calculate Checksum
with urlopen(url) as response:
  hasher = hashlib.sha256()
  for byte_block in iter(lambda: response.read(4096), b''):
    hasher.update(byte_block)
  checksum = hasher.hexdigest()

# Update chocolateyInstall Powershell Script
with open(CHOCOLATEYINSTALL_FILEPATH, 'r') as file :
  chocolateyInstallData = file.read()

chocolateyInstallData = chocolateyInstallData.replace('%%URL%%', url)
chocolateyInstallData = chocolateyInstallData.replace('%%CHECKSUM%%', checksum)

with open(CHOCOLATEYINSTALL_FILEPATH, 'w') as file:
  file.write(chocolateyInstallData)

