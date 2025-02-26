#!/bin/bash
source scripts/arch/util.sh

basePackages=(
  #libsecret
  #gnome-keyring
  flatpak
  tuned
  gamemode
)

# Base packages
printf "Installing base Packages...\n"
for BASE_PACKAGES in "${basePackages[@]}"; do
    install_package "$BASE_PACKAGES"
done

# Add user to the gamemode group
printf " Adding user to the gamemode group...\n"
sudo usermod -aG gamemode "$USER"

#enables tuneD for handling power profiles in an automated fashion
printf " Activating Tuned Services...\n"
sudo systemctl enable --now tuned

printf "\n%.0s" {1..2}
