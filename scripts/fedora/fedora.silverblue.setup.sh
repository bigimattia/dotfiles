#!/bin/bash

# Remove Fedora Workstation apps
apps_to_remove=(
    firefox
    firefox-langpacks
    fedora-bookmarks
)

fedora_flatpaks=(
    org.gnome.Calendar
    org.gnome.Calculator
    org.gnome.Characters
    org.gnome.clocks
    org.gnome.Connections
    org.gnome.Contacts
    org.gnome.font-viewer
    org.gnome.Logs
    org.gnome.Maps
    org.gnome.Papers
    org.gnome.TextEditor
    org.gnome.Weather
)

system_flatpaks=(
    org.gnome.baobab
    org.gnome.Calendar
    org.gnome.Calculator
    org.gnome.clocks
    org.gnome.Connections
    org.gnome.Contacts
    org.gnome.Decibels
    org.gnome.font-viewer
    org.gnome.Loupe
    org.gnome.Maps
    org.gnome.Showtime
    org.gnome.SimpleScan
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
    org.chromium.Chromium
)

echo "Do you want to remove the default Fedora Silverblue apps? (y/n)"
read -r remove_apps
if [[ "$remove_apps" == "y" ]]; then
    sudo rpm-ostree override remove "${apps_to_remove[@]}" -y
    for remove_fedora_flatpak in "${fedora_flatpaks[@]}"; do
        flatpak remove "$remove_fedora_flatpak" -y
    done
fi

echo "Do you want to install the Fedora Workstation apps as Flatpak? (y/n)"
read -r install_flatpaks
if [[ "$install_flatpaks" == "y" ]]; then
    for app in "${system_flatpaks[@]}"; do
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