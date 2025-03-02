#!/bin/bash
source scripts/arch/shared/util.sh

# Required packages
required_packages=(
    hyprland
    hyprpolkitagent
    kitty
    qt5-wayland
    qt6-wayland
    uwsm # Universal wayland session manager https://github.com/Vladimir-csp/uwsm
    xdg-desktop-portal-hyprland
)

# Status bar, notifications, launcher packages
useful_packages=(
    swaync # Notifications
    waybar # Status bar
    wofi # Launcher
    cliphist # Clipboard history
    grim # Screenshot utility
    slurp # Select a region for screenshot
    hypridle # Idle management
    hyprlock # Lock screen
    thunar # File manager
    wlogout # Logout manager
)

# Extra packages
extra_packages=(
    mpv
    mpv-pris
    wl-clipboard
)

# Combine all packages into one array
all_packages=(
    "${required_packages[@]}"
    "${extra_packages[@]}"
    "${useful_packages[@]}"
)

# Install all packages
printf "Installing all hyprland and extra packages...\n"
for package in "${all_packages[@]}"; do
    install_package "$package"
done
