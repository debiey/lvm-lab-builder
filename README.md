# LVM Lab Builder 🐧

An interactive Bash script that creates a **safe, virtual Logical Volume Manager (LVM) practice environment** using loop devices.  
Designed for **learning, teaching, and RHCSA exam preparation** — no real disks required.

---

## 🎯 Why This Tool Exists

While preparing for RHCSA, accessing official Red Hat labs can be difficult due to limited or unstable internet access.  
This tool was built to **remove that barrier** by allowing learners to practice LVM concepts locally on any Linux system.

---

## ✨ Features

- 📦 Creates **two 5GB virtual disks** (10GB total)
- 🔁 Attaches disks using **loop devices** (safe & non-destructive)
- 🧠 Step-by-step **guided learning mode**
- 🎨 Color-coded output for clarity
- ⏸️ Pauses between steps for explanation and practice
- ⚠️ Disk space checks before execution
- 🧪 Ideal for **hands-on LVM practice**

---

## 🛠️ What You Can Practice With This Lab

- Physical Volumes (PV)
- Volume Groups (VG)
- Logical Volumes (LV)
- Extending and reducing volumes
- LVM commands used in RHCSA:
  - `pvcreate`, `vgcreate`, `lvcreate`
  - `lvextend`, `vgs`, `lvs`, `pvs`

---

## 📁 What the Script Creates

```text
~/lvm_lab/
├── disk1.img   (5GB virtual disk)
├── disk2.img   (5GB virtual disk)
