#!/bin/bash
# prakhar shukla 24BCE10117
# oss assignment - checking packages

pkg=$1
# default to git if nothing given
[ -z "$pkg" ] && pkg="git"

echo "Checking: $pkg"
echo "========================"

# check if installed - works on my ubuntu laptop
# might break on other systems idk
dpkg -l "$pkg" 2>/dev/null | grep "^ii" > /dev/null
if [ $? -eq 0 ]; then
    echo "[OK] $pkg is installed"
    
    # get version - copied from stackoverflow
    ver=$(dpkg -l "$pkg" | grep "^ii" | awk '{print $3}')
    echo "Version: $ver"
    
    # show some info
    echo ""
    dpkg -s "$pkg" 2>/dev/null | grep -E "^(Package|Version|Maintainer)" || echo "no info found"
else
    echo "[NOT FOUND] $pkg"
    echo "Install: sudo apt install $pkg"
fi

# license info - from memory might be wrong
echo ""
echo "License:"
case "$pkg" in
    git) echo "GPL v2 (Linus Torvalds)" ;;
    firefox) echo "MPL 2.0 i think" ;;
    vlc) echo "LGPL or something" ;;
    python3) echo "PSF license" ;;
    *) echo "probably open source, check google" ;;
esac
