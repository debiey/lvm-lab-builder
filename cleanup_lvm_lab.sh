#!/bin/bash

echo "Cleaning up LVM Lab Environment..."

# Find loop devices associated with the lab
LOOP_DEVICES=$(losetup -a | grep "$HOME/lvm_lab" | cut -d: -f1)

if [ -z "$LOOP_DEVICES" ]; then
  echo "No loop devices found for lvm_lab."
else
  for dev in $LOOP_DEVICES; do
    echo "Detaching $dev"
    sudo losetup -d "$dev"
  done
fi

# Remove lab directory
rm -rf "$HOME/lvm_lab"

echo "Cleanup complete."
