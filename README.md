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
 
How to Use
1. Clone the repository
git clone https://github.com/<your-username>/lvm-lab-builder.git
cd lvm-lab-builder

2. Make the script executable
chmod +x lvm_setup.sh

3. Run the script
./lvm_setup.sh


Follow the on-screen instructions carefully.

⚠️ Requirements

Linux system

Bash shell

At least 10GB free disk space

dd, losetup, df (available on most Linux distros)

Run as a user with sufficient permissions

🧑‍🎓 Who This Is For

RHCSA candidates

Linux students and beginners

Linux instructors and tutors

Anyone learning LVM without access to physical disks

🧼 Cleanup (Optional)

To remove the lab:

Detach loop devices

Delete ~/lvm_lab

(Manual cleanup is intentional to encourage learning.)

📜 License

MIT License — free to use, modify, and share.

🙌 Author

Chioma
Linux Instructor | RHCSA Certified| Bash Scripting Enthusiast

Built to learn. Built to teach.



├── disk1.img   (5GB virtual disk)
├── disk2.img   (5GB virtual disk)
