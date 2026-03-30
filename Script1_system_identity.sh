#!/bin/bash
# Prakhar Shukla 24BCE10117
# OSS Assignment - Git audit

echo "========================================"
echo "    SYSTEM INFO - Git Open Source Audit"
echo "========================================"
echo ""

# basic info
name="Prakhar Shukla"
reg="24BCE10117"
echo "Name: $name"
echo "Reg: $reg"
echo ""

# system stuff
echo "Kernel: $(uname -r)"
echo "User: $(whoami)"
echo "Home: $HOME"

# distro - might not work on all systems
distro=$(lsb_release -d 2>/dev/null | cut -f2)
if [ -z "$distro" ]; then
    distro="Unknown"
fi
echo "OS: $distro"

# uptime (different flags on different systems)
echo "Uptime: $(uptime)"

# date
echo "Date: $(date)"

# git version
git --version

echo ""
echo "========================================"
echo "Git uses GPL v2 license"
echo "Linux also uses GPL v2"
echo "Copyleft means share alike"
echo "========================================"
