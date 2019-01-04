#!/bin/bash

partUSB=/media/memory0
# Mount the partition on USB stick.
mount /dev/sdb3 $partUSB || exit 1

echo 
cryptsetup luksOpen $partUSB SLAK || exit 1

echo
mount /dev/mapper/SLAK /home/ || exit 1

echo "==== Done ===="
df -h
