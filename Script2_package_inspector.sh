#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author      : Prakhar Shukla
# Reg. No.    : 24BCE10117
# Course      : Open Source Software | VIT Bhopal
# Description : Checks if a FOSS package is installed, shows
#               version and metadata, and prints a philosophy
#               note using a case statement.
# Usage       : ./script2_package_inspector.sh [package-name]
#               Default package: git
# ============================================================

# --- Accept package name from $1 or default to git ---
# ${1:-git} means: use $1 if provided, otherwise use "git"
PACKAGE=${1:-git}

echo "========================================================"
echo "           FOSS PACKAGE INSPECTOR"
echo "  Checking : $PACKAGE"
echo "========================================================"
echo ""

# --- Detect which package manager is available ---
# 'command -v' checks if a program exists without running it
if command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
elif command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
else
    echo "  ERROR: No supported package manager found (dpkg or rpm)."
    echo "  This script supports Debian/Ubuntu (dpkg) and Fedora/RHEL (rpm)."
    exit 1
fi

echo "  Package Manager : $PKG_MANAGER"
echo ""

# -------------------------------------------------------
# --- if-then-else: check whether the package is installed
# -------------------------------------------------------
if [ "$PKG_MANAGER" = "dpkg" ]; then

    # dpkg -l lists installed packages; grep "^ii" matches installed+configured
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then

        INSTALLED=true

        # Extract version: awk prints the 3rd field from the matching line
        VERSION=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii" | awk '{print $3}')
        echo "  [INSTALLED]  $PACKAGE  |  Version: $VERSION"
        echo ""
        echo "  --- Package Metadata (dpkg -s) ---"

        # dpkg -s gives full package info; grep -E filters key fields
        dpkg -s "$PACKAGE" 2>/dev/null \
            | grep -E "^(Package|Version|Maintainer|Homepage|Architecture)" \
            | while IFS=: read -r KEY VAL; do
                printf "  %-15s : %s\n" "$KEY" "$VAL"
              done

    else
        INSTALLED=false
        echo "  [NOT INSTALLED]  $PACKAGE is not installed on this system."
        echo "  To install on Ubuntu/WSL: sudo apt install $PACKAGE -y"
    fi

else
    # rpm-based check
    if rpm -q "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        VERSION=$(rpm -q "$PACKAGE" --qf "%{VERSION}")
        echo "  [INSTALLED]  $PACKAGE  |  Version: $VERSION"
        echo ""
        echo "  --- Package Metadata (rpm -qi) ---"
        rpm -qi "$PACKAGE" 2>/dev/null \
            | grep -E "^(Name|Version|License|Summary|URL)" \
            | while IFS=: read -r KEY VAL; do
                printf "  %-15s : %s\n" "$KEY" "$VAL"
              done
    else
        INSTALLED=false
        echo "  [NOT INSTALLED]  $PACKAGE is not installed on this system."
        echo "  To install on Fedora/RHEL: sudo dnf install $PACKAGE -y"
    fi
fi

echo ""

# -------------------------------------------------------
# --- case statement: print philosophy note by package name
# The case construct matches $PACKAGE against patterns
# -------------------------------------------------------
echo "  --- Open Source Philosophy Note ---"
echo ""

case "$PACKAGE" in

    git)
        echo "  Git — Linus Torvalds built Git in 2005 after BitKeeper"
        echo "  revoked its free license for Linux kernel developers."
        echo "  It became the backbone of every developer's workflow."
        echo "  License: GNU General Public License v2 (GPL v2)"
        ;;

    libreoffice*)
        echo "  LibreOffice — Born from a community fork when Oracle"
        echo "  acquired OpenOffice.org. Proof that open licenses"
        echo "  protect communities from corporate control."
        echo "  License: Mozilla Public License 2.0 (MPL 2.0)"
        ;;

    firefox*)
        echo "  Firefox — Mozilla's stand for an open, user-respecting"
        echo "  web. A nonprofit outcompeting trillion-dollar companies."
        echo "  License: Mozilla Public License 2.0 (MPL 2.0)"
        ;;

    vlc*)
        echo "  VLC — Started as a student project in Paris to stream"
        echo "  campus video. Now plays anything, everywhere."
        echo "  License: LGPL v2.1+ / GPL v2+"
        ;;

    apache2|httpd)
        echo "  Apache HTTP Server — The open web server that powered"
        echo "  the internet's growth since 1995."
        echo "  License: Apache License 2.0"
        ;;

    mysql*|mariadb*)
        echo "  MySQL/MariaDB — At the heart of millions of web stacks."
        echo "  A lesson in dual-licensing and community forks."
        echo "  License: GPL v2 / Commercial Dual"
        ;;

    python3|python*)
        echo "  Python — Community-designed for readability. Its PSF"
        echo "  license enabled an entire scientific and AI ecosystem."
        echo "  License: Python Software Foundation License (PSF)"
        ;;

    curl|wget)
        echo "  $PACKAGE — The unsung internet plumbing of open source."
        echo "  Embedded in billions of devices, trusted everywhere."
        echo "  License: MIT (curl) / GPL v3 (wget)"
        ;;

    *)
        # Wildcard default for any unrecognised package
        echo "  $PACKAGE is an open-source tool contributing to the"
        echo "  culture of transparency and community-driven development."
        echo "  Check its LICENSE file for the specific freedoms granted."
        ;;

esac

echo ""
echo "========================================================"
echo "  Inspection complete."
echo "========================================================"
