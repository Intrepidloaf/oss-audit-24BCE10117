#!/bin/bash
# Script 5 - manifesto - Prakhar Shukla 24BCE10117

echo "Open Source Manifesto Generator"
echo "==============================="

read -p "Tool you use daily: " tool
read -p "What freedom means: " freedom
read -p "What you'd build: " build

if [ -z "$tool" ] || [ -z "$freedom" ] || [ -z "$build" ]; then
    echo "Error: fill all fields"
    exit 1
fi

out="manifesto_$(whoami).txt"

echo "My Open Source Manifesto" > $out
echo "Date: $(date)" >> $out
echo "" >> $out
echo "I use $tool daily. Freedom means $freedom." >> $out
echo "I'd build $build and share it open source." >> $out
echo "Git uses GPL v2." >> $out

echo "Saved to $out:"
cat $out
