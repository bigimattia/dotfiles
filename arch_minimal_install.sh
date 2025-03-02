#!/bin/bash

# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
    echo "${ERROR}  This script should ${WARNING}NOT${RESET} be executed as root!! Exiting......."
    printf "\n%.0s" {1..2}
    exit 1
fi

# Warning message
echo "Warning: This script will make significant changes to your system."
echo "It is meant to be run ONLY on a minimal arch installation."
echo "Will install and setup Hyprland with custom binds, using uwsm."
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

# Run the install.sh script
runScript scripts/arch/base.sh
runScript scripts/arch/bluetooth.sh
runScript scripts/arch/pipewire.sh
runScript scripts/arch/hyprland.sh
runScript scripts/arch/dotfiles.sh

# Ask if the user wants to install zsh
echo "Do you want to install and setup zsh? (y/n)"
read -r install_zsh
if [[ "$install_zsh" == "y" ]]; then

    # Ask if the user wants to set zsh as the default shell
    echo "Do you want to set zsh as the default shell? (y/n)"
    read -r set_zsh_default
    if [[ "$set_zsh_default" == "y" ]]; then
        chsh -s $(which zsh)
    fi

    # Run the zsh.sh script
    runScript scripts/zsh.setup.sh
fi


# Ask if the user wants to remove Fedora Flatpak repository and add Flathub
echo "Do you want to add Flathub? (y/n)"
read -r configure_flatpak
if [[ "$configure_flatpak" == "y" ]]; then
    # Add Flathub repository if not already present
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    # user as well
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Ask if the user wants to set up git
echo "Do you want to set up git? (y/n)"
read -r setup_git
if [[ "$setup_git" == "y" ]]; then
    runScript scripts/git.setup.sh
fi

# Ask to hide grub at startup
echo "Do you want to hide grub at start? (y/n)"
read -r hide_grub
if [[ "hide_grub" == "y" ]]; then
    sudo grub2-editenv - set menu_auto_hide=1
fi

# Ask if the user wants to reboot the system now
echo "Do you want to reboot the system now? (y/n)"
read -r reboot_now
if [[ "$reboot_now" == "y" ]]; then
    sudo reboot
else
    echo "Please reboot your system as soon as possible to apply all changes."
fi

echo "Have a nice day!"