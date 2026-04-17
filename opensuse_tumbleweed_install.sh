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

# Check if the user is running GNOME or KDE
DE=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')

if [[ "$DE" == *"gnome"* ]]; then
    echo "You are running GNOME Desktop Environment."
    runScript scripts/gnome.setup.sh
    runScript scripts/opensuse/opensuse.tumbleweed.gnome.setup.sh
elif [[ "$DE" == *"kde"* ]]; then
    echo "You are running KDE Desktop Environment."
    runScript scripts/opensuse/opensuse.tumbleweed.kde.setup.sh
# elif [[ "$DE" == *"cosmic"* ]]; then
#     echo "You are running COSMIC Desktop Environment."
#     runScript scripts/fedora/fedora.cosmic.setup.sh
else
    echo "You are running an unsupported Desktop Environment."
    exit 1
fi

# Ask if the user wants to fix wine gaming on suse
echo "Do you want to enable selinuxuser_execmod? This allows you to run games through wine. They will all crash otherwise (y/n)"
read -r selinuxuser_execmod
if [[ "$selinuxuser_execmod" == "y" ]]; then
    sudo setsebool -P selinuxuser_execmod 1
    #@TODO use instead :  sudo zypper install selinux-policy-targeted-gaming
fi


# Ask if the user wants to install zsh
echo "Do you want to install and setup zsh? (y/n)"
read -r install_zsh
if [[ "$install_zsh" == "y" ]]; then
    sudo zypper install zsh -y

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
runScript scripts/git.setup.sh