#!/bin/bash

# Remove Fedora Workstation apps
apps_to_remove=(
    abrt-desktop
    ark
    #cosmic-edit #there's no flatpak yet
    #cosmic-player #there's no flatpak yet
    fedora-bookmarks
    firefox
    gnome-calculator
    gnome-system-monitor
    libreoffice-core
    nheko
    okular
    rhythmbox
    thunderbird
    vlc
)

# Install flatpak apps
flatpak_apps=(
    org.mozilla.firefox
    # org.kde.kwrite # cosmic-edit
    org.gnome.Calculator
    # org.gnome.Showtime # videos - cosmic-player
    # org.gnome.Decibels # audio - cosmic-player
    org.gnome.Loupe # images
    org.mozilla.Thunderbird
    org.libreoffice.LibreOffice
)

user_flatpak_apps=(
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

echo "Do you want to remove the default Fedora apps? (y/n)"
read -r remove_apps
if [[ "$remove_apps" == "y" ]]; then
    sudo dnf remove "${apps_to_remove[@]}" -y
fi

echo "Do you want to install default apps as Flatpak? (y/n)"
read -r install_flatpaks
if [[ "$install_flatpaks" == "y" ]]; then
    for app in "${flatpak_apps[@]}"; do
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