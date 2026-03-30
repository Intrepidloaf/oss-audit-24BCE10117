#!/bin/bash
# prakhar 24BCE10117
# disk check for oss lab

echo "Disk Check"
echo "=========="

# these dirs are important i think
for dir in /etc /home /usr/bin /var/log; do
  if [ -d "$dir" ]; then
    # get info - works on ubuntu
    perms=`ls -ld $dir | awk '{print $1}'`
    owner=`ls -ld $dir | awk '{print $3}'`  
    size=$(du -sh $dir 2>/dev/null | cut -f1)
    echo "$dir -> $perms $owner $size"
  else
    echo "$dir not found"
  fi
done

echo ""
echo "Git paths:"
# check where git stuff is
for p in /usr/bin/git /usr/lib/git-core $HOME/.gitconfig; do
  if test -e $p; then
    ls -ld $p 2>/dev/null
  else
    echo "$p: missing"
  fi
done

echo ""
# disk free space
df -h | grep -v tmpfs | head -5

# TODO: add more paths later
