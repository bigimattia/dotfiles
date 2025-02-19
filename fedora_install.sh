#!/bin/bash

# Ask for sudo privileges
if [ "$EUID" -ne 0 ]; then
    echo "This script requires sudo privileges. Please run with sudo."
    exit 1
fi

# Warning message
echo "Warning: This script will make significant changes to your system including:"
echo "- Installing zsh"
echo "- Removing certain Fedora Workstation apps"
echo "- Adding Flathub repository"
echo "- Installing apps as Flatpak"
echo "- Updating the system"
echo "Do you wish to continue? (y/n)"
read -r response
if [[ "$response" != "y" ]]; then
    echo "Operation cancelled."
    exit 1
fi

# MAIN

sudo dnf install zsh -y

# Remove Fedora Flatpak repository if present
flatpak remote-delete fedora

# Add Flathub repository if not already present
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# user as well
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

# Remove Fedora Workstation apps

# Remove Fedora Workstation apps
apps_to_remove=(
    abrt-desktop
    baobab
    evince
    fedora-bookmarks
    firefox
    gnome-boxes
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-connections
    gnome-contacts
    gnome-font-viewer
    gnome-initial-setup
    gnome-logs
    gnome-maps
    gnome-text-editor
    gnome-weather
    libreoffice-core
    loupe
    mediawriter
    rhythmbox
    simple-scan
    totem
)

sudo dnf remove -y "${apps_to_remove[@]}"

# Install Fedora Workstation apps as Flatpak
apps=(
    org.gnome.baobab
    org.gnome.Calendar
    org.gnome.Calculator
    org.gnome.Characters
    org.gnome.Clocks
    org.gnome.Connections
    org.gnome.Contacts
    org.gnome.font-viewer
    org.gnome.Logs
    org.gnome.Loupe
    org.gnome.Maps
    org.gnome.Papers
    org.gnome.Showtime
    org.gnome.SimpleScan
    org.gnome.TextEditor
    org.gnome.Weather
    org.mozilla.firefox
)

for app in "${apps[@]}"; do
    flatpak install flathub "$app" -y
done

# Update the system
sudo dnf upgrade -y

# Run the install.sh script
./install.sh