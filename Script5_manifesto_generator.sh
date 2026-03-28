#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author      : Prakhar Shukla
# Reg. No.    : 24BCE10117
# Course      : Open Source Software | VIT Bhopal
# Description : Asks the user three interactive questions and
#               composes a personalised open source philosophy
#               statement, saving it to a .txt file.
# Usage       : ./script5_manifesto_generator.sh
# ============================================================

# --- Alias concept demonstration ---
# shopt -s expand_aliases enables aliases to work inside scripts
# (By default, Bash only expands aliases in interactive shells)
shopt -s expand_aliases

# 'alias' creates a shorthand name for a longer command
alias today='date "+%d %B %Y"'
alias underline='printf "%0.s=" {1..56}; echo'
alias byline='echo "  Written using Git — the version control system that"'

echo "========================================================"
echo "        OPEN SOURCE MANIFESTO GENERATOR"
echo "  Student : Prakhar Shukla  |  Reg: 24BCE10117"
echo "  Audit   : Git | GPL v2"
echo "========================================================"
echo ""
echo "  Every developer who has ever typed 'git commit' or"
echo "  'git push' has touched the work of Linus Torvalds —"
echo "  work he gave away freely under the GPL."
echo ""
echo "  Answer three questions to generate your own"
echo "  open source philosophy statement."
echo ""
echo "========================================================"
echo ""

# -------------------------------------------------------
# --- read: capture interactive user input
# -p "prompt" displays a prompt on the same line as input
# The answer is stored in a named variable
# -------------------------------------------------------
read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
echo ""
read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Validate: none of the three answers should be empty ---
# -z tests whether a string is zero-length
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  ERROR: All three answers are required."
    echo "  Please re-run the script and fill in every answer."
    exit 1
fi

# --- Build metadata using command substitution and alias ---
DATE=$(today)           # uses the 'today' alias defined above
AUTHOR=$(whoami)        # current Linux username

# --- Output filename: dynamically constructed with string concatenation ---
OUTPUT="manifesto_${AUTHOR}.txt"

echo ""
echo "========================================================"
echo "  Generating your manifesto..."
echo "========================================================"
echo ""

# -------------------------------------------------------
# --- Write the manifesto to a file
# >  : redirect and OVERWRITE (creates file or clears existing)
# >> : redirect and APPEND (adds to end of file)
# -------------------------------------------------------

# Write the header — use > to start fresh each run
echo "========================================================" > "$OUTPUT"
echo "           MY OPEN SOURCE MANIFESTO"                      >> "$OUTPUT"
echo "  Author  : $AUTHOR"                                      >> "$OUTPUT"
echo "  Date    : $DATE"                                        >> "$OUTPUT"
echo "  Audit   : Git (GPL v2) | VIT Bhopal OSS Course"        >> "$OUTPUT"
echo "========================================================"  >> "$OUTPUT"
echo ""                                                          >> "$OUTPUT"

# Write the personalised paragraph using the user's answers
# Variables are interpolated inside double-quoted strings
echo "  Every day, I depend on $TOOL to do my work — software" >> "$OUTPUT"
echo "  built openly and shared freely by people who believed"  >> "$OUTPUT"
echo "  that tools should belong to everyone."                  >> "$OUTPUT"
echo ""                                                          >> "$OUTPUT"
echo "  To me, freedom means $FREEDOM. That is exactly the"    >> "$OUTPUT"
echo "  freedom that Linus Torvalds encoded into Git when he"   >> "$OUTPUT"
echo "  licensed it under the GPL: the freedom to run it,"     >> "$OUTPUT"
echo "  study it, change it, and pass it on."                  >> "$OUTPUT"
echo ""                                                          >> "$OUTPUT"
echo "  If I could give one thing back to the world of open"   >> "$OUTPUT"
echo "  source, it would be $BUILD — free for anyone to"       >> "$OUTPUT"
echo "  use, fork, and improve. Not because a license forces"  >> "$OUTPUT"
echo "  me to. Because sharing is what makes the work matter." >> "$OUTPUT"
echo ""                                                          >> "$OUTPUT"
echo "  I commit to building in the open."                     >> "$OUTPUT"
echo ""                                                          >> "$OUTPUT"
echo "                    — $AUTHOR | $DATE"                    >> "$OUTPUT"
echo "========================================================"  >> "$OUTPUT"

# --- Confirm the file was written ---
echo "  Manifesto saved to: $OUTPUT"
echo ""

# --- Display the saved file using cat ---
# cat reads the file and prints it to stdout
cat "$OUTPUT"

echo ""
echo "========================================================"
byline     # uses the 'byline' alias defined at the top
echo "  kept every version of this project intact."
echo "  Share your manifesto — just like open source."
echo "========================================================"
