#!/bin/bash
# prakhar 24BCE10117

echo "========================================"
echo "SYSTEM INFO"
echo "========================================"

# variables
student="Prakhar Shukla"
regno="24BCE10117"
echo "Name: $student"
echo "Reg: $regno"

# system commands
echo "Kernel: `uname -r`"  # old style
echo "User: $(whoami)"      # new style

# git check - works on my laptop
if command -v git >/dev/null 2>&1; then
    git --version 2>&1 | head -1
else
    echo "no git"
fi

# distro (might not work)
distro=$(lsb_release -d 2>/dev/null | cut -f2)
[ -z "$distro" ] && distro="unknown"
echo "OS: $distro"

echo ""
echo "========================================"
echo "Git license: GPL v2"
echo "========================================"
