#!/bin/bash

# lvm_setup_5g.sh
# Step-by-step LVM practice environment setup with 5GB disks
# Follows Method 2 from the guide

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

print_step() {
    echo -e "\n${BLUE}=== Step $1: $2 ===${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}[✓] $1${NC}"
}

print_error() {
    echo -e "${RED}[✗] $1${NC}"
}

print_info() {
    echo -e "${YELLOW}[i] $1${NC}"
}

print_warning() {
    echo -e "${PURPLE}[!] $1${NC}"
}

# Function to pause and wait for user
pause() {
    echo ""
    read -p "Press Enter to continue to next step..."
    echo ""
}

# Clear screen and show header
clear
echo -e "${GREEN}"
echo "=================================================="
echo "    LVM Practice Environment Setup (5GB Edition)"
echo "    Method 2: Step-by-Step (For Learning)"
echo "=================================================="
echo -e "${NC}"

# Check available disk space
print_warning "Checking available disk space..."
FREE_SPACE=$(df -h ~ | awk 'NR==2 {print $4}' | sed 's/G//')
echo "Available space in home directory: ${FREE_SPACE}GB"

if [[ ${FREE_SPACE%.*} -lt 10 ]]; then
    print_warning "Warning: You have less than 10GB free space."
    read -p "Continue anyway? (y/n): " space_confirm
    if [[ $space_confirm != "y" && $space_confirm != "Y" ]]; then
        echo "Setup cancelled."
        exit 0
    fi
fi

# Ask for confirmation
echo ""
echo "This script will:"
echo "1. Create ~/lvm_lab directory"
echo "2. Create two 5GB virtual disks (10GB total)"
echo "3. Set them up as loop devices"
echo "4. Verify the setup"
echo ""
print_warning "Note: This will use 10GB of disk space!"
echo ""
read -p "Continue? (y/n): " confirm
if [[ $confirm != "y" && $confirm != "Y" ]]; then
    echo "Setup cancelled."
    exit 0
fi

# ==========================================
# STEP 1: Create practice directory
# ==========================================
print_step "1" "Create practice directory"

echo "Creating directory: ~/lvm_lab"
mkdir -p ~/lvm_lab

if [ $? -eq 0 ]; then
    print_success "Directory created successfully"
else
    print_error "Failed to create directory"
    exit 1
fi

echo "Changing to ~/lvm_lab"
cd ~/lvm_lab

if [ $? -eq 0 ]; then
    print_success "Changed to ~/lvm_lab"
    echo "Current directory: $(pwd)"
else
    print_error "Failed to change directory"
    exit 1
fi

pause

# ==========================================
# STEP 2: Create virtual disks
# ==========================================
print_step "2" "Create virtual disks"

echo "Creating two 5GB virtual disks..."
print_warning "This will take some time and use 10GB of disk space!"
echo ""
echo "Progress indicators:"
echo "• ████████████████████ 100% = 5GB created"
echo "• This may take 1-2 minutes per disk depending on your system"
echo ""

# Create first disk
print_info "Creating disk1.img (5GB)..."
echo "Starting at: $(date)"
dd if=/dev/zero of=disk1.img bs=1M count=5120 status=progress 2>&1

if [ $? -eq 0 ]; then
    print_success "disk1.img created (5GB)"
    echo "Finished at: $(date)"
else
    print_error "Failed to create disk1.img"
    echo "Tip: You might not have enough disk space. Try smaller disks."
    exit 1
fi

echo ""

# Create second disk
print_info "Creating disk2.img (5GB)..."
echo "Starting at: $(date)"
dd if=/dev/zero of=disk2.img bs=1M count=5120 status=progress 2>&1

if [ $? -eq 0 ]; then
    print_success "disk2.img created (5GB)"
    echo "Finished at: $(date)"
else
    print_error "Failed to create disk2.img"
    echo "Cleaning up..."
    rm -f disk1.img
    exit 1
fi

echo ""
print_success "Both 5GB disks created successfully!"
echo "Checking created files:"
ls -lh disk*.img

pause

# ==========================================
# STEP 3: Set them up as loop devices
# ==========================================
print_step "3" "Set up loop devices"

echo "Setting up loop devices for the 5GB virtual disks..."
echo ""

# Check if loop module is loaded
if ! lsmod | grep -q loop; then
    print_info "Loading loop module..."
    sudo modprobe loop
fi

# Setup first disk
print_info "Setting up disk1.img (5GB) as loop device..."
sudo losetup -fP disk1.img

if [ $? -eq 0 ]; then
    LOOP1=$(sudo losetup -a | grep disk1.img | cut -d: -f1)
    print_success "disk1.img attached as $LOOP1"
else
    print_error "Failed to attach disk1.img"
    exit 1
fi

# Setup second disk
print_info "Setting up disk2.img (5GB) as loop device..."
sudo losetup -fP disk2.img

if [ $? -eq 0 ]; then
    LOOP2=$(sudo losetup -a | grep disk2.img | cut -d: -f1)
    print_success "disk2.img attached as $LOOP2"
else
    print_error "Failed to attach disk2.img"
    exit 1
fi

pause

# ==========================================
# STEP 4: Check they're ready
# ==========================================
print_step "4" "Verify setup"

echo "Checking loop devices..."
echo ""

# Show loop devices
print_info "Current loop devices:"
sudo losetup -a

echo ""
print_info "Disk information using lsblk:"
lsblk | grep loop

echo ""
print_info "Detailed disk information:"
for dev in $LOOP1 $LOOP2; do
    echo "====================================="
    echo "Device: $dev"
    echo "Size: $(sudo blockdev --getsize64 $dev | numfmt --to=iec)"
    echo "Filesystem: $(sudo blkid -o value -s TYPE $dev 2>/dev/null || echo 'None')"
    echo "Partitions:"
    sudo fdisk -l $dev 2>/dev/null | grep -A5 "^Disk $dev" || echo "  No partition table"
    echo ""
done

# ==========================================
# STEP 5: Show what we've created
# ==========================================
print_step "5" "Setup Complete"

echo -e "${GREEN}"
echo "=================================================="
echo "            SETUP COMPLETE!"
echo "    Two 5GB disks ready for LVM practice"
echo "=================================================="
echo -e "${NC}"

echo "You should see output similar to:"
echo -e "${YELLOW}"
echo "/dev/loop0: [64768]:5120000 (/home/kali/lvm_lab/disk1.img)"
echo "/dev/loop1: [64768]:5120000 (/home/kali/lvm_lab/disk2.img)"
echo -e "${NC}"
echo ""

print_info "Summary:"
echo "• Practice directory: ~/lvm_lab"
echo "• Virtual disks: disk1.img, disk2.img (5GB each)"
echo "• Loop devices: $LOOP1, $LOOP2"
echo "• Total space: 10GB"
echo "• Disk usage: $(du -sh ~/lvm_lab | cut -f1)"
echo ""

# ==========================================
# STEP 6: Practice commands (Updated for 5GB)
# ==========================================
print_step "6" "Practice Commands (5GB Edition)"

cat << EOF

${GREEN}Now practice these LVM commands with your 5GB disks:${NC}

1. ${YELLOW}Create Physical Volumes:${NC}
   sudo pvcreate $LOOP1
   sudo pvcreate $LOOP2

2. ${YELLOW}Create Volume Group:${NC}
   sudo vgcreate my_vg $LOOP1 $LOOP2

3. ${YELLOW}Create Logical Volumes (try different sizes):${NC}
   sudo lvcreate -n lv_small -L 1G my_vg
   sudo lvcreate -n lv_medium -L 3G my_vg
   sudo lvcreate -n lv_large -l 80%FREE my_vg

4. ${YELLOW}Create different filesystems:${NC}
   sudo mkfs.ext4 /dev/my_vg/lv_small
   sudo mkfs.xfs /dev/my_vg/lv_medium
   sudo mkfs.ext3 /dev/my_vg/lv_large

5. ${YELLOW}Mount them:${NC}
   sudo mkdir -p /mnt/{lvm_small,lvm_medium,lvm_large}
   sudo mount /dev/my_vg/lv_small /mnt/lvm_small
   sudo mount /dev/my_vg/lv_medium /mnt/lvm_medium
   sudo mount /dev/my_vg/lv_large /mnt/lvm_large
   df -h /mnt/lvm_*

6. ${YELLOW}Practice extending LVs (with 5GB you have room!):${NC}
   sudo lvextend -L +500M /dev/my_vg/lv_small
   sudo resize2fs /dev/my_vg/lv_small

7. ${YELLOW}Create LVM snapshots:${NC}
   sudo lvcreate -s -n lv_snap -L 500M /dev/my_vg/lv_medium

EOF

# ==========================================
# STEP 7: Cleanup instructions
# ==========================================
print_step "7" "Cleanup Instructions"

cat << EOF
${YELLOW}When you're done practicing, clean up with:${NC}

# 1. Unmount everything
sudo umount /mnt/lvm_* 2>/dev/null

# 2. Remove LVM components
sudo lvremove -f /dev/my_vg/* 2>/dev/null
sudo vgremove my_vg 2>/dev/null
sudo pvremove $LOOP1 $LOOP2 2>/dev/null

# 3. Detach loop devices
sudo losetup -d $LOOP1 $LOOP2 2>/dev/null

# 4. Remove practice files (THIS WILL DELETE 10GB!)
cd ~
rm -rf ~/lvm_lab

${GREEN}Or use the included cleanup script!${NC}
EOF

# ==========================================
# Create a cleanup script
# ==========================================
cat > ~/lvm_lab/cleanup_5g.sh << 'EOF'
#!/bin/bash
echo "=== LVM Practice Cleanup (5GB Edition) ==="
echo ""
echo "This will remove all 10GB of practice files!"
echo ""
read -p "Are you sure? (y/n): " confirm
if [[ $confirm != "y" && $confirm != "Y" ]]; then
    echo "Cleanup cancelled."
    exit 0
fi

echo ""
echo "1. Unmounting any mounts..."
sudo umount /mnt/lvm_* 2>/dev/null
sudo umount /mnt/lvm_test 2>/dev/null
sudo umount /mnt/lvm_practice 2>/dev/null

echo ""
echo "2. Removing LVM components..."
sudo lvremove -f $(sudo lvs --noheadings -o lv_path 2>/dev/null) 2>/dev/null
sudo vgremove -f $(sudo vgs --noheadings -o vg_name 2>/dev/null) 2>/dev/null
sudo pvremove $(sudo pvs --noheadings -o pv_name 2>/dev/null) 2>/dev/null

echo ""
echo "3. Detaching loop devices..."
sudo losetup -d $(sudo losetup -a | grep "disk[0-9]*.img" | cut -d: -f1) 2>/dev/null
sudo losetup -D 2>/dev/null

echo ""
echo "4. Cleaning up 10GB of files..."
cd ~
rm -rf ~/lvm_lab

echo ""
echo "✅ Cleanup complete! 10GB freed."
EOF

chmod +x ~/lvm_lab/cleanup_5g.sh

echo ""
print_success "Cleanup script created: ~/lvm_lab/cleanup_5g.sh"
echo "Run it with: sudo ~/lvm_lab/cleanup_5g.sh"
echo ""

# ==========================================
# Create a practice scenarios file
# ==========================================
cat > ~/lvm_lab/practice_scenarios.txt << 'EOF'
=== LVM Practice Scenarios (5GB Disks) ===

Scenario 1: Basic LVM Setup
1. Create PVs on both disks
2. Create VG named "datavg"
3. Create 3 LVs: root (2G), home (2G), var (1G)
4. Create filesystems and mount them

Scenario 2: Extending Practice
1. Create LV of 1GB
2. Fill it with 800MB of data
3. Extend it to 2GB
4. Resize filesystem without data loss

Scenario 3: LVM Snapshots
1. Create 2GB LV with files
2. Create 500MB snapshot
3. Modify original files
4. Restore from snapshot

Scenario 4: Multiple VGs
1. Create VG1 with disk1 only
2. Create VG2 with disk2 only
3. Create LVs in both VGs
4. Migrate data between them

Scenario 5: Real-world Simulation
1. Create / (1G), /home (1G), /var (1G), /tmp (500M)
2. Create swap (500M)
3. Configure /etc/fstab for all
4. Test reboots
EOF

print_success "Practice scenarios saved: ~/lvm_lab/practice_scenarios.txt"

# ==========================================
# Final message
# ==========================================
echo -e "${GREEN}"
echo "=================================================="
echo "    Ready to practice LVM with 5GB disks!"
echo "    Your environment is set up with 10GB total."
echo "=================================================="
echo -e "${NC}"
echo ""
echo "Loop devices: $LOOP1, $LOOP2"
echo "Total practice space: 10GB"
echo ""
echo "Next steps:"
echo "1. Check devices: sudo losetup -a"
echo "2. Start with: sudo pvcreate $LOOP1"
echo "3. View scenarios: cat ~/lvm_lab/practice_scenarios.txt"
echo ""
echo "Happy practicing!"
