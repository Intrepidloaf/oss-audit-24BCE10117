#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author      : Prakhar Shukla
# Reg. No.    : 24BCE10117
# Course      : Open Source Software | VIT Bhopal
# Description : Loops through key system directories and reports
#               permissions, ownership, and disk usage. Also
#               audits Git-specific directories and binaries.
# Usage       : ./script3_disk_auditor.sh
# Note        : Run with sudo for full size accuracy on /etc
# ============================================================

# --- Array of standard Linux system directories to audit ---
# Arrays in Bash use parentheses and space-separated values
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share" "/opt")

# --- Git-specific paths to audit ---
# These are the canonical locations Git installs to on Ubuntu/WSL
GIT_PATHS=(
    "/usr/bin/git"
    "/usr/lib/git-core"
    "/usr/share/git-core"
    "/usr/share/doc/git"
    "/etc/gitconfig"
    "$HOME/.gitconfig"
    "$HOME/.git-credentials"
)

echo "========================================================"
echo "          DISK AND PERMISSION AUDITOR"
echo "  Host : $(hostname)  |  Date : $(date '+%d %B %Y')"
echo "========================================================"
echo ""
echo "  --- Standard System Directory Audit ---"
echo ""

# printf for fixed-width aligned columns
printf "  %-22s %-28s %-8s\n" "Directory" "Perms / Owner:Group" "Size"
printf "  %-22s %-28s %-8s\n" "---------" "-------------------" "----"

# -------------------------------------------------------
# --- for loop: iterate over every item in the DIRS array
# "${DIRS[@]}" expands to all array elements
# -------------------------------------------------------
for DIR in "${DIRS[@]}"; do

    # [ -d "$DIR" ] returns true if DIR exists and is a directory
    if [ -d "$DIR" ]; then

        # ls -ld shows directory details without listing contents
        # awk '{print $1}' extracts field 1 = permissions string (e.g. drwxr-xr-x)
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')

        # awk '{print $3}' = owner name, awk '{print $4}' = group name
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # du -sh: disk usage, human-readable (-h), summary only (-s)
        # cut -f1 extracts the size field (before the tab)
        # 2>/dev/null silences permission-denied errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        printf "  %-22s %-28s %-8s\n" \
            "$DIR" \
            "$PERMS $OWNER:$GROUP" \
            "${SIZE:-N/A}"
    else
        printf "  %-22s %-28s %-8s\n" "$DIR" "[Does not exist]" "-"
    fi

done

echo ""
echo "========================================================"
echo "    Git-Specific Path Audit (Our Audited FOSS Project)"
echo "========================================================"
echo ""
echo "  Git distributes itself across several standard paths"
echo "  following the Linux Filesystem Hierarchy Standard (FHS):"
echo ""

# -------------------------------------------------------
# --- Second for loop: check each Git path individually
# -------------------------------------------------------
for GPATH in "${GIT_PATHS[@]}"; do

    # Check if it exists as a directory OR a regular file
    if [ -d "$GPATH" ] || [ -f "$GPATH" ]; then

        PERMS=$(ls -ld "$GPATH" | awk '{print $1}')
        OWNER=$(ls -ld "$GPATH" | awk '{print $3}')
        GROUP=$(ls -ld "$GPATH" | awk '{print $4}')
        SIZE=$(du -sh "$GPATH" 2>/dev/null | cut -f1)

        echo "  [FOUND]     $GPATH"
        echo "              Perms: $PERMS  |  Owner: $OWNER:$GROUP  |  Size: ${SIZE:-N/A}"
        echo ""

    else
        echo "  [NOT FOUND] $GPATH"
        echo ""
    fi

done

echo "========================================================"
echo "  --- Filesystem Mount Points (df summary) ---"
echo ""

# df -h: disk free, human-readable
# grep -v filters out lines we don't need (tmpfs is RAM-backed; udev is device nodes)
df -h 2>/dev/null \
    | grep -v "^tmpfs" \
    | grep -v "^udev" \
    | grep -v "^Filesystem" \
    | while read -r FSLINE; do
        echo "  $FSLINE"
      done

echo ""
echo "========================================================"
echo "  Disk and permission audit complete."
echo "========================================================"
