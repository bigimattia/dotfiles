#!/bin/bash
source scripts/arch/shared/util.sh

basePackages=(
  brightnessctl
  flatpak
  gamemode
  git
  gnome-keyring
  libsecret
  nano
  network-manager-applet
  networkmanager # already contains nmtui command
  nm-connection-editor
  playerctl
  tuned
  unzip
  xdg-users-dir
  xdg-utils
  zsh
)

# Base packages
printf "Installing base Packages...\n"
for BASE_PACKAGES in "${basePackages[@]}"; do
    install_package "$BASE_PACKAGES"
done

#enables NetworkManager for handling power profiles in an automated fashion
printf " Activating NetworkManager Services...\n"
sudo systemctl enable --now NetworkManager

# Add user to the gamemode group
printf " Adding user to the gamemode group...\n"
sudo usermod -aG gamemode "$USER"

#enables tuneD for handling power profiles in an automated fashion
printf " Activating Tuned Services...\n"
sudo systemctl enable --now tuned

printf "\n%.0s" {1..2}
