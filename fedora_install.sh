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
runScript() {
    local script_path="$1"
    if [ ! -x "$script_path" ]; then
        chmod +x "$script_path"
    fi
    "$script_path"
}

# Remove Fedora Flatpak repository if present
flatpak remote-delete fedora

# Add Flathub repository if not already present
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# user as well
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

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

echo "Do you want to remove the default Fedora Workstation apps? (y/n)"
read -r remove_apps
if [[ "$remove_apps" == "y" ]]; then
    sudo dnf remove -y "${apps_to_remove[@]}"
fi

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

echo "Do you want to install the Fedora Workstation apps as Flatpak? (y/n)"
read -r install_flatpaks
if [[ "$install_flatpaks" == "y" ]]; then
    for app in "${apps[@]}"; do
        flatpak install flathub "$app" -y
    done
fi

# Ask if the user wants to install zsh
echo "Do you want to install and setup zsh? (y/n)"
read -r install_zsh
if [[ "$install_zsh" == "y" ]]; then
    sudo dnf install zsh -y

    # Ask if the user wants to set zsh as the default shell
    echo "Do you want to set zsh as the default shell? (y/n)"
    read -r set_zsh_default
    if [[ "$set_zsh_default" == "y" ]]; then
        chsh -s $(which zsh)
    fi

    # Run the install.sh script
    runScript ./scripts/zsh.setup.sh
fi

# Ask if the user wants to set GNOME keybinds
echo "Do you want to set GNOME keybinds? (y/n)"
read -r set_gnome_keybinds
if [[ "$set_gnome_keybinds" == "y" ]]; then
    runScript ./scripts/gnome-keybinds.sh
fi

# Ask if the user wants to set up the 65% keyboard FN keys fix
echo "Since some 65% keyboards defaults to fn keys"
echo "triggering special keys instead of F1-F12 keys,"
echo "Do you want to set up the 65% keyboard FN keys fix? (y/n)"
echo "[skip if you don't have a 65% keyboard]"
read -r set_65x_fn_keys
if [[ "$set_65x_fn_keys" == "y" ]]; then
    runScript ./scripts/65x-fn-keys-fix.sh

fi

# Ask if the user wants to set up git
echo "Do you want to set up git? (y/n)"
read -r setup_git
if [[ "$setup_git" == "y" ]]; then
    echo "Enter your git email:"
    read -r git_email
    echo "Enter your git username:"
    read -r git_username

    git config --global user.email "$git_email"
    git config --global user.name "$git_username"

    ssh-keygen -t ed25519 -C "$git_email"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo "Add the following SSH key to your GitHub account:"
    cat ~/.ssh/id_ed25519.pub
    echo "Press any key to continue..."
    read -n 1 -s
fi

# Ask if the user wants to enable multiprofile Bluetooth
echo "Do you want to enable multiprofile Bluetooth? (y/n)"
read -r enable_multiprofile_bt
if [[ "$enable_multiprofile_bt" == "y" ]]; then
    sudo sed -i 's/#MultiProfile = off/MultiProfile = multiple/' /etc/bluetooth/main.conf
    echo "Multiprofile Bluetooth has been enabled."
fi

# Update the system
sudo dnf upgrade -y

# Ask if the user wants to reboot the system now
echo "Do you want to reboot the system now? (y/n)"
read -r reboot_now
if [[ "$reboot_now" == "y" ]]; then
    sudo reboot
else
    echo "Please reboot your system as soon as possible to apply all changes."
fi

echo "Have a nice day!"