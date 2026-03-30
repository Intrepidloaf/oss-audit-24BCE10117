#!/bin/bash
# prakhar shukla 24BCE10117
# oss assignment - git audit
# submitted late because wifi was down

echo "========================================"
echo "SYSTEM INFO - Git Open Source Audit"
echo "========================================"
echo ""

# my info
name="Prakhar Shukla"
reg="24BCE10117"
course="OSS"
echo "Name: $name"
echo "Reg: $reg"  
echo "Course: $course"
echo ""

# debug: echo "starting system check"

# system stuff - got these commands from google
echo "Kernel: $(uname -r)"
echo "User: $(whoami)"
echo "Home Directory: $HOME"

# distro check - lsb_release might not work on all systems
# my friend said to use cat /etc/os-release but this works for me
distro=$(lsb_release -d 2>/dev/null | cut -f2)
if [ -z "$distro" ]; then
    distro="Unknown Linux"
    # TODO: fix this later
fi
echo "Operating System: $distro"

# other system info
echo "Uptime: $(uptime)"
echo "Date/Time: $(date)"

# check if git exists
if which git > /dev/null 2>&1; then
    git --version
else
    echo "git not installed"
fi

echo ""
echo "========================================"
echo "License Information:"
echo "Git is under GPL v2"
echo "Linux kernel is also GPL v2"
echo "Copyleft means you have to share source code"
echo "========================================"

# unused variable for future extension
# semester="6th"
