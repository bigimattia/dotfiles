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
runScript scripts/arch/extra/base.sh
runScript scripts/arch/extra/bluetooth.sh
runScript scripts/arch/extra/pipewire.sh
runScript scripts/arch/extra/hyprland.sh
runScript scripts/arch/extra/dotfiles.sh

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

    # Run the zsh.sh script
    runScript scripts/zsh.setup.sh
fi
