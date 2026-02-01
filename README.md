# LVM Lab Builder 🐧

An interactive Bash tool that builds a **safe, virtual Logical Volume Manager (LVM) practice environment** using loop devices.

This project was created to help learners **practice LVM hands-on without access to physical disks or paid lab platforms**, making it especially useful for **RHCSA exam preparation**.

---

## 🎯 Motivation

While preparing for RHCSA, accessing official Red Hat labs can be challenging due to unstable or limited internet access.  
To overcome this, I built a local solution that allows **full LVM practice on any Linux system**, using virtual disks created with Bash scripting.

This tool is intentionally **educational, interactive, and non-destructive**.

---

## ✨ Features

- 📦 Creates **two 5GB virtual disks** (10GB total)
- 🔁 Attaches disks using **loop devices**
- 🧠 Step-by-step guided execution
- 🎨 Color-coded terminal output
- ⏸️ Pauses between steps for learning and explanation
- ⚠️ Disk space verification before execution
- 🧪 Ideal for LVM practice and demonstrations

---

## 🛠️ Skills & Concepts Practiced

- Logical Volume Manager (LVM)
- Physical Volumes (PV)
- Volume Groups (VG)
- Logical Volumes (LV)
- Linux storage fundamentals
- Bash scripting best practices
- Loop devices (`losetup`)

---

## 📁 Lab Structure

```text
~/lvm_lab/
├── disk1.img   (5GB)
├── disk2.img   (5GB)
## How to Use
1. Clone the repository
**git clone https://github.com/debiey/lvm-lab-builder.git
cd lvm-lab-builder
**
2. Make the script executable
chmod +x lvm_setup.sh

3. Run the script
./lvm_setup.sh


Follow the on-screen instructions carefully.

⚠️ Requirements

Linux OS

Bash shell

At least 10GB free disk space

Standard Linux utilities: dd, df, losetup

Sufficient permissions to attach loop devices

🧼 Cleanup

A separate cleanup script is provided to safely remove the lab when done.

🧑‍🎓 Intended Audience

RHCSA candidates

Linux students and self-learners

Linux instructors and tutors

Anyone learning Linux storage concepts

📜 License

MIT License — free to use, modify, and distribute.

🙌 Author

Chioma
Linux Instructor | RHCSA Candidate | Bash Scripting Enthusiast

Built to learn. Built to teach.




