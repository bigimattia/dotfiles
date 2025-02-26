#!/bin/bash
source scripts/arch/util.sh

# Required packages
required_packages=(
    uwsm # Universal wayland session manager https://github.com/Vladimir-csp/uwsm
    kitty
    hyprland
    hyprpolkitagent
    xdg-desktop-portal-hyprland
    qt5-wayland
    qt6-wayland
)

# Extra packages
extra_packages=(
    hypridle # Idle management
    hyprlock # Lock screen
    cliphist # Clipboard history
    grim # Screenshot utility
    slurp # Select a region for screenshot
    thunar # File manager
)

# Status bar, notifications, launcher packages
status_bar_packages=(
    waybar # Status bar
    swaync # Notifications
    wofi # Launcher
)

# Combine all packages into one array
all_packages=(
    "${required_packages[@]}"
    "${extra_packages[@]}"
    "${status_bar_packages[@]}"
)

# Install all packages
printf "Installing all hyprland and extra packages...\n"
for package in "${all_packages[@]}"; do
    install_package "$package"
done
