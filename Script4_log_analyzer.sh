#!/bin/bash
# Script 4 - log analyzer - Prakhar Shukla 24BCE10117

logfile=$1
keyword=${2:-error}

if [ -z "$logfile" ]; then
    echo "Usage: $0 <logfile> [keyword]"
    exit 1
fi

if [ ! -f "$logfile" ]; then
    echo "File not found: $logfile"
    exit 1
fi

echo "Analyzing $logfile for '$keyword'"
echo ""

count=0
while read line; do
    if echo "$line" | grep -i "$keyword" > /dev/null; then
        count=$((count + 1))
    fi
done < "$logfile"

echo "Found $count matches"

echo ""
echo "Last 5 matches:"
grep -i "$keyword" "$logfile" | tail -5

echo ""
total=$(wc -l < "$logfile")
echo "Total lines: $total"
echo "Match rate: $((count * 100 / total))%"
