#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author      : Prakhar Shukla
# Reg. No.    : 24BCE10117
# Course      : Open Source Software | VIT Bhopal
# Description : Displays a formatted welcome screen showing
#               system information and open-source license
#               context for the Git open source audit.
# Usage       : ./script1_system_identity.sh
# ============================================================

# --- Student and project variables ---
STUDENT_NAME="Prakhar Shukla"
REG_NO="24BCE10117"
SOFTWARE_CHOICE="Git"
SOFT_LICENSE="GNU General Public License v2 (GPL v2)"
OS_LICENSE="GNU General Public License v2 (GPL v2)"

# --- Gather system info using command substitution $() ---
# uname -r returns the Linux kernel release string
KERNEL=$(uname -r)

# lsb_release -d gives a human-readable distro description
# cut -f2- trims the "Description:" label, leaving just the value
DISTRO=$(lsb_release -d 2>/dev/null | cut -f2-)

# Fallback: read /etc/os-release if lsb_release is unavailable
if [ -z "$DISTRO" ]; then
    DISTRO=$(grep PRETTY_NAME /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"')
fi

# whoami returns the name of the currently logged-in user
USER_NAME=$(whoami)

# $HOME is a built-in shell variable for the user's home directory
HOME_DIR=$HOME

# uptime -p gives a human-readable uptime string (e.g., "up 2 hours, 5 minutes")
UPTIME=$(uptime -p 2>/dev/null || uptime)

# date with a format string for readable date and time
DATETIME=$(date '+%A, %d %B %Y  |  %I:%M %p')

# git --version extracts the installed Git version
GIT_VERSION=$(git --version 2>/dev/null || echo "Git not found")

# --- WSL detection ---
# WSL kernels contain "microsoft" or "WSL" in the uname string
if uname -r | grep -qi "microsoft\|wsl"; then
    ENV_TYPE="Windows Subsystem for Linux (WSL)"
else
    ENV_TYPE="Native Linux"
fi

# --- Display the report ---
echo "========================================================"
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT      "
echo "========================================================"
echo ""
echo "  Student   : $STUDENT_NAME"
echo "  Reg. No.  : $REG_NO"
echo "  Course    : Open Source Software | VIT Bhopal"
echo "  Audit Of  : $SOFTWARE_CHOICE"
echo ""
echo "========================================================"
echo "                  SYSTEM INFORMATION                     "
echo "========================================================"
echo ""
echo "  Environment  : $ENV_TYPE"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged User  : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date & Time  : $DATETIME"
echo ""
echo "  Git Version  : $GIT_VERSION"
echo ""
echo "========================================================"
echo "               OPEN SOURCE LICENSE INFO                  "
echo "========================================================"
echo ""
echo "  The Linux kernel running this system is licensed under:"
echo "  --> $OS_LICENSE"
echo ""
echo "  $SOFTWARE_CHOICE (our audit subject) is licensed under:"
echo "  --> $SOFT_LICENSE"
echo ""
echo "  GPL v2 guarantees four essential freedoms:"
echo "    [0] Freedom to run the program for any purpose"
echo "    [1] Freedom to study and modify the source code"
echo "    [2] Freedom to redistribute copies"
echo "    [3] Freedom to distribute modified versions"
echo ""
echo "  Crucially, GPL v2 is copyleft: any software that"
echo "  incorporates GPL v2 code must itself be GPL v2."
echo "  This is what keeps Git — and Linux — permanently free."
echo ""
echo "========================================================"
echo "          System identity check complete."
echo "========================================================"
