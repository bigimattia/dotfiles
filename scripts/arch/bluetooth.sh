#!/bin/bash
source scripts/arch/shared/util.sh

bluetoothList=(
  blueman
  bluez
  bluez-utils
)

# Bluetooth
printf "Installing Bluetooth Packages...\n"
 for BLUE in "${bluetoothList[@]}"; do
   install_package "$BLUE"
  done

printf " Activating Bluetooth Services...\n"
sudo systemctl enable --now bluetooth.service

printf "\n%.0s" {1..2}
