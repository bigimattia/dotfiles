#!/bin/bash

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

echo "Do you want to remove the default Fedora Workstation apps? (y/n)"
read -r remove_apps
if [[ "$remove_apps" == "y" ]]; then
    sudo dnf remove "${apps_to_remove[@]}" -y
fi

echo "Do you want to install the Fedora Workstation apps as Flatpak? (y/n)"
read -r install_flatpaks
if [[ "$install_flatpaks" == "y" ]]; then
    for app in "${apps[@]}"; do
        flatpak install flathub "$app" -y
    done
fi