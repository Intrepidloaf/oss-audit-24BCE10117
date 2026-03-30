#!/bin/bash
# Prakhar Shukla 24BCE10117
# OSS Assignment - 3 scripts in one

echo "=== System Info ==="
echo "Name: Prakhar Shukla"
echo "Reg: 24BCE10117"
echo "Kernel: $(uname -r)"
echo "User: $(whoami)"
echo "Git: $(git --version)"

echo ""
echo "=== Package Check ==="
pkg=${1:-git}
if dpkg -l "$pkg" | grep "^ii" > /dev/null; then
    echo "$pkg installed"
    dpkg -s "$pkg" | grep -E "Package|Version"
else
    echo "$pkg not installed"
fi

echo ""
echo "=== Disk Check ==="
for dir in /etc /home /usr/bin; do
    echo "$dir: $(du -sh $dir 2>/dev/null | cut -f1)"
done

echo ""
echo "Git uses GPL v2"
