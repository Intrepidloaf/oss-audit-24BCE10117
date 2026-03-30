#!/bin/bash
# Script 2 - check package - Prakhar Shukla 24BCE10117

# use first argument or default to git
pkg=${1:-git}

echo "Checking package: $pkg"
echo ""

# check if installed using dpkg
if dpkg -l "$pkg" 2>/dev/null | grep "^ii" > /dev/null; then
    echo "$pkg is installed"
    
    # get version
    ver=$(dpkg -l "$pkg" | grep "^ii" | awk '{print $3}')
    echo "Version: $ver"
    
    # show some info
    echo ""
    echo "Package info:"
    dpkg -s "$pkg" | grep -E "Package|Version|Maintainer"
    
else
    echo "$pkg is NOT installed"
    echo "Install with: sudo apt install $pkg"
fi

echo ""

# case statement for philosophy part
case "$pkg" in
    git)
        echo "Git was made by Linus Torvalds in 2005"
        echo "License: GPL v2"
        ;;
    firefox)
        echo "Firefox is by Mozilla"
        echo "License: MPL 2.0"
        ;;
    vlc)
        echo "VLC plays anything"
        echo "License: LGPL"
        ;;
    *)
        echo "$pkg is open source software"
        ;;
esac
