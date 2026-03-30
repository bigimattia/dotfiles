#!/bin/bash

# Packages and patterns to remove and lock based on 'zypper ll' output
packages=(
    "MozillaFirefox"
    "baobab"
    "dconf-editor"
    "epiphany"
    "evince"
    "evolution"
    "evolution-ews"
    "extension-manager"
    "gnome-calculator"
    "gnome-characters"
    "gnome-clocks"
    "gnome-connections"
    "gnome-contacts"
    "gnome-extensions"
    "gnome-logs"
    "gnome-maps"
    "gnome-packagekit"
    "gnome-text-editor"
    "gnome-tweaks"
    "gnome-weather"
    "orca"
    "patterns-gnome-gnome_games"
    "patterns-gnome-gnome_imaging"
    "snapshot"
    "sushi"
    "totem"
)

patterns=(
    "games"
    "imaging"
    "multimedia"
    "office"
)

flatpak_apps=(
    "org.gnome.Calculator"
    "org.gnome.clocks"
    "org.gnome.Contacts"
    "org.gnome.Maps"
    "org.gnome.TextEditor"
    "org.gnome.Weather"
)

echo "This script will remove and lock several GNOME packages and patterns to prevent reinstallation."
echo "Do you wish to continue? (y/n)"
read -r response
if [[ "$response" != "y" ]]; then
    echo "Operation cancelled."
    exit 1
fi

echo "Removing specified packages and patterns..."

# Remove packages (-u removes unneeded dependencies)
sudo zypper remove -y -u "${packages[@]}"

# Remove patterns
for p in "${patterns[@]}"; do
    sudo zypper remove -y -u "pattern:$p"
done

# Lock the packages to prevent reinstallation during 'zypper dup'
echo "Adding zypper locks..."
sudo zypper addlock "${packages[@]}"

# Lock the patterns
for p in "${patterns[@]}"; do
    sudo zypper addlock "pattern:$p"
done

echo "Cleanup and locking completed."

echo "Do you want to install the removed apps as Flatpaks (system-wide)? (y/n)"
read -r install_flatpaks
if [[ "$install_flatpaks" == "y" ]]; then
    # Ensure flathub is added
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    for app in "${flatpak_apps[@]}"; do
        sudo flatpak install --system flathub "$app" -y
    done
    echo "Flatpak applications installed successfully."
fi