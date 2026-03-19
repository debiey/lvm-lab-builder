# Architecture

This project simulates a real Linux storage stack using loop devices.

## Flow

1. Disk images are created using `dd`
2. Images are attached as loop devices using `losetup`
3. LVM is initialized:
   - Physical Volumes (PV)
   - Volume Group (VG)
   - Logical Volume (LV)

## Diagram

[ Disk Image ] → [ Loop Device ] → [ PV ] → [ VG ] → [ LV ]

## Why Loop Devices?

Loop devices allow files to behave like block devices, enabling safe experimentation without real hardware.
