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

echo "Cleanup and locking completed successfully."