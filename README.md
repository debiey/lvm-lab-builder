# 🧱 LVM Lab Builder

> A safe, offline Linux lab for mastering Logical Volume Management — no real disks needed.

[![Shell](https://img.shields.io/badge/language-Bash-green)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux-orange)](https://www.linux.org/)

---

## 🔍 The Problem

Practicing LVM on a real system is risky — one wrong command can wipe your storage. Most learners either skip LVM entirely or break their machines trying to learn it.

**LVM Lab Builder solves this** by simulating real disks using loop devices, giving you a full, destructible LVM environment that can't touch your actual hardware.

---

## 🚀 What It Does

LVM Lab Builder spins up a complete LVM stack in seconds:

```
[ Disk Image ] → [ Loop Device ] → [ PV ] → [ VG ] → [ LV ]
```

- Creates 2 virtual disk images (`.img`)
- Attaches them as loop devices
- Builds Physical Volumes → Volume Groups → Logical Volumes
- Tears everything down cleanly when done

---

## ✅ Built For

| User | Use Case |
|------|----------|
| 🎓 RHCSA candidates | Hands-on exam prep |
| 👨‍🏫 Linux instructors | Classroom demos without risk |
| 🛠️ Sysadmins | Safely testing storage configs |
| 🐧 Linux learners | Learning LVM from scratch |

---

## ⚡ Quick Start

```bash
# Clone the repo
git clone https://github.com/debiey/lvm-lab-builder.git
cd lvm-lab-builder

# Install LVM2 if needed
sudo apt install lvm2 -y

# Build the lab
sudo bash scripts/lvm_setup.sh

# Tear it down when done
sudo bash scripts/cleanup_lvm_lab.sh
```

> ⚠️ Uses loop devices only — your real disks are never touched. Still, review scripts before running with `sudo`.

---

## 🧠 What You'll Learn

After using this lab you'll be able to:
- Create and manage Physical Volumes, Volume Groups, and Logical Volumes
- Understand disk abstraction and storage layering in Linux
- Perform real sysadmin-level storage workflows safely

---

## 🗺️ Roadmap

- [ ] Challenge mode with task-based exercises
- [ ] Filesystem creation and mount point integration
- [ ] Automated answer validation
- [ ] Session logging and replay

---

## 👤 Author

**Chioma Obiagboso** — Linux Systems Engineer · AI Tools Developer · RHCSA Certified

[GitHub](https://github.com/debiey) · [Mimir](https://github.com/debiey/mimir)

---

## 📜 License

MIT — free to use, fork, and learn from.
