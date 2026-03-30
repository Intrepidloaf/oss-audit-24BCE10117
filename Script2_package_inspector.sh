#!/bin/bash
# prakhar - 24BCE10117 - oss lab
# checking if packages installed

# my laptop uses ubuntu so dpkg works
# FIXME: might not work on fedora but whatever

pkg=$1

# if no arg given, check git
if [ "$pkg" == "" ]; then
  pkg="git"
fi

echo "Checking package: $pkg"
echo "========================"

# check if installed - got this from stackoverflow
# https://stackoverflow.com/questions/1298066
dpkg -l "$pkg" 2>/dev/null | grep "^ii" > /dev/null
if [ $? -eq 0 ]; then
    echo "[OK] $pkg is installed"
    
    # get version number
    ver=$(dpkg -l "$pkg" | grep "^ii" | awk '{print $3}')
    echo "version: $ver"
    
    # show metadata
    echo ""
    echo "--- Package Info ---"
    dpkg -s "$pkg" | grep "Package:" | head -1
    dpkg -s "$pkg" | grep "Version:" | head -1
    dpkg -s "$pkg" | grep "Maintainer:" || echo "no maintainer info"
else
    echo "[X] $pkg not found"
    echo ""
    echo "to install run:"
    echo "sudo apt-get install $pkg"
    echo ""
    # echo "or download from website"  # commented out, not sure
fi

# license info - did this from memory might be wrong
echo ""
echo "License:"
if [ "$pkg" = "git" ]; then
  echo "GPL v2"
elif [ "$pkg" = "firefox" ]; then
  echo "MPL something"
elif [ "$pkg" = "vlc" ]; then
  echo "LGPL i think"
elif [ "$pkg" = "python3" ]; then
  echo "PSF"
else
  echo "probably GPL or MIT"
  # check with: cat /usr/share/doc/$pkg/copyright 2>/dev/null | head -5
fi

# debug: echo "done at $(date)" >> /tmp/script2.log
