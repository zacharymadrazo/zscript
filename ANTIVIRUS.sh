#!/bin/bash
ANTIVURUS=clamav,clamtk
if [ ! $ANTIVURUS ]; then
sudo apt-get update
sudo apt-get install $ANTIVURUS
else
echo "Antivirus protection already exists"
fi