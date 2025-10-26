#!/bin/bash

# Remove Fedora Workstation apps
apps_to_remove=(
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
    snapshot
    totem
)

# Install Fedora Workstation apps as Flatpak
apps=(
    org.gnome.baobab
    org.gnome.Calendar
    org.gnome.Calculator
    org.gnome.Characters
    org.gnome.clocks
    org.gnome.Connections
    org.gnome.Contacts
    org.gnome.Decibels
    org.gnome.font-viewer
    org.gnome.Logs
    org.gnome.Loupe
    org.gnome.Maps
    org.gnome.Papers
    org.gnome.Showtime
    org.gnome.SimpleScan
    org.gnome.Snapshot
    org.gnome.TextEditor
    org.gnome.Weather
    org.mozilla.firefox
)

user_flatpak_apps=(
    com.github.tchx84.Flatseal
    com.mattjakeman.ExtensionManager
    org.fedoraproject.MediaWriter
    org.gimp.GIMP
    org.kde.kdenlive
    com.valvesoftware.Steam
    com.discordapp.Discord
    org.localsend.localsend_app
    com.spotify.Client
    com.bitwarden.desktop
    com.visualstudio.code
    com.heroicgameslauncher.hgl
    com.google.Chrome
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
        flatpak install --system flathub "$app" -y
    done
fi

echo "Do you want to install the extra user apps as Flatpak? (y/n)"
read -r install_user_flatpak_apps
if [[ "$install_user_flatpak_apps" == "y" ]]; then
    for user_app in "${user_flatpak_apps[@]}"; do
        flatpak install --user flathub "$user_app" -y
    done
fi
