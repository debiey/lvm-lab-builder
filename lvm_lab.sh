#!/bin/bash

# =========================
# LVM Lab CLI Entry Point
# =========================

set -e

# Colors (optional but nice)
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# =========================
# Functions
# =========================

setup_lvm() {
    echo -e "${GREEN}Starting LVM setup...${NC}"
    bash scripts/lvm_setup.sh
}

cleanup_lvm() {
    echo -e "${RED}Cleaning up LVM lab...${NC}"
    bash scripts/cleanup.sh
}

# =========================
# CLI Argument Handling
# =========================

case "$1" in
  --setup)
    setup_lvm
    ;;
  --cleanup)
    cleanup_lvm
    ;;
  *)
    echo "Usage: $0 --setup | --cleanup"
    exit 1
    ;;
esac
