#!/bin/bash

# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
    echo "${ERROR}  This script should ${WARNING}NOT${RESET} be executed as root!! Exiting......."
    printf "\n%.0s" {1..2} 
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
    source "$script_path"
}

# Ask if the user wants to remove Fedora Flatpak repository and add Flathub
echo "Do you want to remove the Fedora Flatpak repository and add Flathub? (y/n)"
read -r configure_flatpak
if [[ "$configure_flatpak" == "y" ]]; then
    # Remove Fedora Flatpak repository if present
    flatpak remote-delete fedora
    # Add Flathub repository if not already present
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    # user as well
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Check if the user is running GNOME or KDE
DE=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')

if [[ "$DE" == *"gnome"* ]]; then
    echo "You are running GNOME Desktop Environment."
    runScript scripts/gnome.setup.sh
    runScript scripts/fedora/fedora.gnome.setup.sh
elif [[ "$DE" == *"kde"* ]]; then
    echo "You are running KDE Desktop Environment."
    runScript scripts/fedora/fedora.kde.setup.sh
else
    echo "You are running an unsupported Desktop Environment."
    exit 1
fi

# Ask if the user wants to set up the 65% keyboard FN keys fix
echo "Since some 65% keyboards defaults to fn keys"
echo "triggering special keys instead of F1-F12 keys,"
echo "Do you want to set up the 65% keyboard FN keys fix? (y/n)"
echo "[skip if you don't have a 65% keyboard]"
read -r set_65x_fn_keys
if [[ "$set_65x_fn_keys" == "y" ]]; then
    runScript scripts/65x-fn-keys-fix.sh
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
    runScript scripts/zsh.setup.sh
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
echo "PLEASE NOTE: This will enable the ability to connect to multiple Bluetooth profiles at the same time."
echo "This may cause issues with some devices."
echo "Only enable if you know what you are doing."
echo " !! WARN !! READ ABOVE !! WARN !!" 
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