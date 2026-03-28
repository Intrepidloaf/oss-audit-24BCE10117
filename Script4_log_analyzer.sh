#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author      : Prakhar Shukla
# Reg. No.    : 24BCE10117
# Course      : Open Source Software | VIT Bhopal
# Description : Reads a log file line by line, counts keyword
#               occurrences, shows last 5 matches, and prints
#               a summary. Includes retry logic for missing or
#               empty files. Has WSL-aware fallback paths.
# Usage       : ./script4_log_analyzer.sh <logfile> [keyword]
#   Examples  :
#     ./script4_log_analyzer.sh /var/log/dpkg.log git
#     ./script4_log_analyzer.sh /var/log/syslog error
#     sudo ./script4_log_analyzer.sh /var/log/auth.log failed
# ============================================================

# --- $1 = log file path, $2 = keyword (default: "error") ---
LOGFILE=$1
KEYWORD=${2:-"error"}

# --- Counter variable initialised to zero ---
COUNT=0

# --- Maximum retry attempts if file is missing or empty ---
MAX_RETRIES=2
ATTEMPT=0

# --- WSL-aware fallback log paths, in order of preference ---
# WSL Ubuntu may not have /var/log/messages (RHEL convention)
FALLBACK_LOGS=(
    "/var/log/dpkg.log"
    "/var/log/syslog"
    "/var/log/auth.log"
    "/var/log/apt/history.log"
)

echo "========================================================"
echo "                LOG FILE ANALYZER"
echo "  Keyword  : '$KEYWORD'"
echo "========================================================"
echo ""

# -------------------------------------------------------
# --- Input validation: check that $1 was provided
# -------------------------------------------------------
if [ -z "$LOGFILE" ]; then
    echo "  WARNING: No log file specified. Using default fallback."
    echo ""
    # Find the first fallback log that exists and has content
    for FB in "${FALLBACK_LOGS[@]}"; do
        if [ -f "$FB" ] && [ -s "$FB" ]; then
            LOGFILE="$FB"
            echo "  Auto-selected log: $LOGFILE"
            break
        fi
    done

    # If still empty after fallbacks, exit
    if [ -z "$LOGFILE" ]; then
        echo "  ERROR: No readable log file found. Try running with sudo."
        echo "  Usage: $0 <logfile> [keyword]"
        exit 1
    fi
    echo ""
fi

# -------------------------------------------------------
# --- Retry loop: attempt to validate the file up to MAX_RETRIES times
# This implements a do-while style using a while counter
# -------------------------------------------------------
while [ $ATTEMPT -lt $MAX_RETRIES ]; do

    ATTEMPT=$((ATTEMPT + 1))  # increment counter

    # Check if the specified path exists as a regular file
    if [ ! -f "$LOGFILE" ]; then
        echo "  [Attempt $ATTEMPT] File not found: '$LOGFILE'"

        if [ $ATTEMPT -lt $MAX_RETRIES ]; then
            # Try the next fallback log
            for FB in "${FALLBACK_LOGS[@]}"; do
                if [ -f "$FB" ] && [ -s "$FB" ]; then
                    LOGFILE="$FB"
                    echo "  Retrying with fallback: $LOGFILE"
                    break
                fi
            done
        else
            echo "  All fallbacks exhausted. Cannot continue."
            exit 1
        fi
        continue   # jump back to top of while loop
    fi

    # Check if the file has content (non-zero size)
    if [ ! -s "$LOGFILE" ]; then
        echo "  [Attempt $ATTEMPT] File is empty: '$LOGFILE'"

        if [ $ATTEMPT -lt $MAX_RETRIES ]; then
            for FB in "${FALLBACK_LOGS[@]}"; do
                if [ -f "$FB" ] && [ -s "$FB" ] && [ "$FB" != "$LOGFILE" ]; then
                    LOGFILE="$FB"
                    echo "  Retrying with fallback: $LOGFILE"
                    break
                fi
            done
        else
            echo "  All fallback files are empty. Exiting."
            exit 1
        fi
        continue
    fi

    # If we reach here, file exists and has content — break out
    echo "  [Attempt $ATTEMPT] Log file validated: $LOGFILE"
    FILESIZE=$(du -sh "$LOGFILE" 2>/dev/null | cut -f1)
    echo "  File size : $FILESIZE"
    break

done

echo ""
echo "  Scanning for keyword: '$KEYWORD' (case-insensitive)..."
echo ""

# -------------------------------------------------------
# --- while read loop: read the log file line by line
# IFS= preserves leading/trailing whitespace in each line
# -r prevents backslash sequences from being interpreted
# < "$LOGFILE" redirects the file as stdin for the loop
# -------------------------------------------------------
while IFS= read -r LINE; do

    # if-then inside the loop: check if LINE contains KEYWORD
    # grep -iq: case-insensitive (-i), quiet/no output (-q), returns 0 if found
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # increment counter using arithmetic expansion
    fi

done < "$LOGFILE"

echo "  Result: '$KEYWORD' matched $COUNT line(s) in $LOGFILE"
echo ""

# -------------------------------------------------------
# --- Display last 5 matching lines for context
# grep retrieves all matching lines; tail -5 takes the last 5
# -------------------------------------------------------
echo "  --- Last 5 Matching Lines ---"
echo ""

MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" 2>/dev/null | tail -5)

if [ -z "$MATCHES" ]; then
    echo "  (No lines matched '$KEYWORD' in $LOGFILE)"
else
    # Pipe MATCHES into a while loop to print each line with a prefix
    echo "$MATCHES" | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
fi

echo ""

# -------------------------------------------------------
# --- Summary statistics
# -------------------------------------------------------
TOTAL_LINES=$(wc -l < "$LOGFILE")   # wc -l counts lines; < feeds file as stdin

echo "  --- Summary ---"
echo "  Log file       : $LOGFILE"
echo "  Total lines    : $TOTAL_LINES"
echo "  Keyword        : '$KEYWORD'"
echo "  Matching lines : $COUNT"

# Guard against division by zero
if [ "$TOTAL_LINES" -gt 0 ]; then
    PERCENT=$(( COUNT * 100 / TOTAL_LINES ))
    echo "  Match rate     : ${PERCENT}%"
fi

echo ""
echo "========================================================"
echo "  Log analysis complete."
echo "========================================================"
