#!/bin/bash

# Remove Fedora Workstation apps
apps_to_remove=(
    firefox
    firefox-langpacks
    fedora-bookmarks
)

fedora_flatpaks=(
    org.kde.elisa
    org.kde.kmines
    org.kde.kmahjongg
    org.kde.skanpage
    org.kde.gwenview
    org.kde.kolourpaint
    org.kde.krdc
    org.kde.kcalc
    org.kde.okular
)

system_flatpaks=(
    org.kde.elisa
    org.kde.skanpage
    org.kde.gwenview
    org.kde.kolourpaint
    org.kde.krdc
    org.kde.kcalc
    org.kde.okular

    com.google.Chrome
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