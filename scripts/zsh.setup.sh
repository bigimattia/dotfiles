#!/bin/bash
if [ -f .zshrc ]; then
    cp .zshrc ~/
else
    echo "File .zshrc does not exist."
fi

if [ -d .zsh ]; then
    cp -r .zsh ~/.zsh
else
    echo "Directory .zsh does not exist."
fi

firaCodeVersion="v3.3.0"
firaCodeUrl="https://github.com/ryanoasis/nerd-fonts/releases/download/$firaCodeVersion/FiraCode.zip"
nvmVersion="v0.40.1"
nvmUrl="https://raw.githubusercontent.com/nvm-sh/nvm/$nvmVersion/install.sh"

MINIMAL_INSTALL=false
INSTALL_AUTOSUGGESTIONS=false
INSTALL_NVM=false
INSTALL_THEME_MINIMAL=false
INSTALL_STARSHIP=false
INSTALL_FIRACODE=false

read -p "Do you want a minimal install? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    MINIMAL_INSTALL=true
    read -p "Do you want to install autosuggestions? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        INSTALL_AUTOSUGGESTIONS=true
    fi

    read -p "Do you want to install nvm? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        INSTALL_NVM=true
    fi

    read -p "Do you want to install Starship? (y/n - n will prompt for minimal theming, leave empty to skip theming entirely) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        INSTALL_STARSHIP=true
        read -p "Do you want to install FiraCode Nerd Font? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            INSTALL_FIRACODE=true
        fi
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        read -p "Do you want to setup a minimal theme? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            INSTALL_THEME_MINIMAL=true
        fi
    fi
fi

if [[ $INSTALL_AUTOSUGGESTIONS == true || $MINIMAL_INSTALL == false ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    echo "# zsh-autosuggestions" >> ~/.zsh/plugin.zsh
    echo "source \$ZSH/plugins/zsh-autosuggestions.zsh" >> ~/.zsh/plugin.zsh
fi

if [[ $INSTALL_NVM == true || $MINIMAL_INSTALL == false ]]; then
    PROFILE=/dev/null bash -c "curl -o- $nvmUrl | bash"
    echo "# nvm" >> ~/.zsh/plugin.zsh
    echo "source \$ZSH/plugins/nvm.zsh" >> ~/.zsh/plugin.zsh
fi

install_firacode_nerd_font() {
    local font_dir="~/.local/share/fonts"
    mkdir -p "$font_dir"
    curl -fLo "$font_dir/FiraCode.zip" $firaCodeUrl
    unzip "$font_dir/FiraCode.zip" -d "$font_dir"
    fc-cache -fv
    rm "$font_dir/FiraCode.zip"
}

if [[ $INSTALL_FIRACODE == true || $MINIMAL_INSTALL == false ]]; then
    install_firacode_nerd_font
fi

# starship MUST be last line in the .zshrc file
if [[ $INSTALL_STARSHIP == true || $MINIMAL_INSTALL == false ]]; then
    echo "# starship" >> ~/.zshrc
    echo "eval \"\$(starship init zsh)\"" >> ~/.zshrc
    if [ -f /usr/local/bin/starship ]; then
        echo "Starship is already installed."
    else
        sh -c "$(curl -sS https://starship.rs/install.sh)"
    fi
elif [[ $INSTALL_THEME_MINIMAL == true ]]; then
    echo "# theme minimal" >> ~/.zsh/plugin.zsh
    echo "source \$ZSH/plugins/theme.minimal.zsh" >> ~/.zsh/plugin.zsh
fi
