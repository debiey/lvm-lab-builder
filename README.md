# LVM Lab Builder

A lightweight, offline Linux lab environment for practicing Logical Volume Management (LVM) using loop devices.

## 🚀 Overview

LVM Lab Builder simulates real disk environments without requiring physical hardware. It allows users to safely create, manage, and destroy LVM setups for hands-on learning and experimentation.

This project is designed for:
- RHCSA / Linux certification preparation
- Linux students and instructors
- System administrators practicing storage management

---

## 🧠 Key Concept

Instead of using real disks, this tool:

1. Creates virtual disk images (`.img`)
2. Attaches them as loop devices
3. Builds LVM structures on top

[ Disk Image ] → [ Loop Device ] → [ PV ] → [ VG ] → [ LV ]

⚙️ Features

Automated LVM setup (PV, VG, LV)
Safe testing using loop devices
Interactive step-by-step execution
Clean teardown (no system damage)
Fully offline operation

📦 Requirements

Linux system
Root privileges
lvm2 installed
Install dependencies:

sudo apt install lvm2 -y
▶️ Usage
1. Clone the repository
git clone https://github.com/debiey/lvm-lab-builder.git
cd lvm-lab-builder

2. Run setup
sudo bash scripts/lvm_setup.sh
3. Cleanup lab
sudo bash scripts/cleanup_lvm_lab.sh

🔍 What This Builds

2 virtual disks
Physical volumes (PV)
Volume group (VG)
Logical volume (LV)

⚠️ Safety

This tool uses loop devices and does not modify your real disks.

However, always review scripts before running with sudo.

🎯 Learning Outcomes

After using this lab, you will understand:

How LVM works (PV, VG, LV)
Disk abstraction in Linux
Storage layering concepts
Real-world system administration workflows

🚧 Future Improvements

Challenge mode (task-based learning)
Filesystem and mounting integration
Automated validation checks
Logging and replay functionality

👤 Author

Chioma Obiagboso
Linux Instructor | System Builder | Open Source Enthusiast

📜 License

MIT License
