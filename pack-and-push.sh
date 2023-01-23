#!/usr/bin/env bash
# Build a .nuspec File for RedNotebook and Push it to Chocolatey

# Build the .nupkg File
choco pack

# Set API Key and Push
choco apikey -k $CHOCO_API_KEY -source https://push.chocolatey.org/
#choco push *.nupkg -s https://push.chocolatey.org/
