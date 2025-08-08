#!/bin/bash

if [ -f dotfiles/.zshrc ]; then
    cp dotfiles/.zshrc ~/
else
    echo "File .zshrc does not exist."
fi

if [ -d dotfiles/.zsh ]; then
    cp -r dotfiles/.zsh ~/
else
    echo "Directory .zsh does not exist."
fi

firaCodeVersion="v3.3.0"
firaCodeUrl="https://github.com/ryanoasis/nerd-fonts/releases/download/${firaCodeVersion}/FiraCode.zip"
nvmVersion="v0.40.1"
nvmUrl="https://raw.githubusercontent.com/nvm-sh/nvm/$nvmVersion/install.sh"

MINIMAL_INSTALL=false
INSTALL_AUTOSUGGESTIONS=false
INSTALL_TABHISTORYCOMPLETION=false
INSTALL_NVM=false
INSTALL_THEME_MINIMAL=false
INSTALL_STARSHIP=false
INSTALL_FIRACODE=false
INSTALL_SDKMAN=false

read -p "Do you want a minimal install? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    MINIMAL_INSTALL=true
    read -p "Do you want to install autosuggestions? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        INSTALL_AUTOSUGGESTIONS=true
    fi

    read -p "Do you want to setup tab + arrow history completion? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        INSTALL_TABHISTORYCOMPLETION=true
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

    read -p "Do you want to install sdkman? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        INSTALL_SDKMAN=true
    fi
fi

if [[ $INSTALL_AUTOSUGGESTIONS == true || $MINIMAL_INSTALL == false ]]; then
    echo "# zsh-autosuggestions" >> ~/.zsh/plugins.zsh
    echo "source \$ZSH/plugins/zsh-autosuggestions.zsh" >> ~/.zsh/plugins.zsh

    if [ -d ~/.zsh/zsh-autosuggestions ]; then
        echo "zsh-autosuggestions is already installed."
    else
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    fi   
fi

if [[ $INSTALL_NVM == true || $MINIMAL_INSTALL == false ]]; then
    echo "# nvm" >> ~/.zsh/plugins.zsh
    echo "source \$ZSH/plugins/nvm.zsh" >> ~/.zsh/plugins.zsh

    if [ -d ~/.nvm ]; then
        echo "NVM is already installed."
    else
        PROFILE=/dev/null bash -c "curl -o- $nvmUrl | bash"
    fi
fi

install_firacode_nerd_font() {
    # macos has a different Font location
    if [[ "$(uname)" == "Darwin" ]]; then
        font_dir="$HOME/Library/Fonts/FiraCodeNerdFont"
    else
        font_dir="$HOME/.local/share/fonts/FiraCodeNerdFont"
    fi
    local font_dir="$HOME/.local/share/fonts/FiraCodeNerdFont" # ~ operator does not expand in the string
    # Scarica il file zip in una posizione temporanea
    local temp_zip="/tmp/FiraCode.zip"
    echo "Scaricamento FiraCode Nerd Font..."
    if ! curl -L -o "$temp_zip" "$firaCodeUrl"; then
        echo "Errore durante il download di FiraCode"
    else 
        mkdir -p "$font_dir"
        # Estrai nella cartella delle font
        unzip -o "$temp_zip" -d "$font_dir"
        if [[ "$(uname)" != "Darwin" ]]; then
            fc-cache -fv
        fi
        rm "$temp_zip"
    fi
}

if [[ $INSTALL_FIRACODE == true || $MINIMAL_INSTALL == false ]]; then
    if [ -d ~/.local/share/fonts/FiraCodeNerdFont ]; then
        echo "FiraCodeFonts is already installed."
    else
        install_firacode_nerd_font
    fi
fi

# starship MUST be last line in the .zshrc file
if [[ $INSTALL_STARSHIP == true || $MINIMAL_INSTALL == false ]]; then
    echo "# starship" >> ~/.zshrc
    echo "eval \"\$(starship init zsh)\"" >> ~/.zshrc
    echo -en '\n' >> ~/.zshrc
    
    if [ -f /usr/local/bin/starship ]; then
        echo "Starship is already installed."
    else
        sh -c "$(curl -sS https://starship.rs/install.sh)"

        cp dotfiles/.config/starship.toml $HOME/.config/
    fi
elif [[ $INSTALL_THEME_MINIMAL == true ]]; then
    echo "# theme minimal" >> ~/.zsh/plugins.zsh
    echo "source \$ZSH/plugins/theme.minimal.zsh" >> ~/.zsh/plugins.zsh
fi

if [[ $INSTALL_TABHISTORYCOMPLETION == true || $MINIMAL_INSTALL == false ]]; then
    echo "# START - Command completion with arrow-key" >> ~/.zsh/plugins/history.zsh
    echo "autoload -Uz compinit" >> ~/.zsh/plugins/history.zsh
    echo "compinit" >> ~/.zsh/plugins/history.zsh

    echo "# Enable arrow-key selection for completion" >> ~/.zsh/plugins/history.zsh
    echo "zstyle ':completion:*' menu select" >> ~/.zsh/plugins/history.zsh

    echo "# Use history-based completion (matches what was typed)" >> ~/.zsh/plugins/history.zsh
    echo "zstyle ':completion:*' completer _history" >> ~/.zsh/plugins/history.zsh

    echo "# Only show history matches that continue what’s already typed" >> ~/.zsh/plugins/history.zsh
    echo "zstyle ':completion:*:history' stop yes" >> ~/.zsh/plugins/history.zsh

    echo "# Remove duplicates in history completion" >> ~/.zsh/plugins/history.zsh
    echo "zstyle ':completion:*' sort false" >> ~/.zsh/plugins/history.zsh

    echo "# Prioritize most recent matches first" >> ~/.zsh/plugins/history.zsh
    echo "zstyle ':completion:*' history-incremental-search-backward yes" >> ~/.zsh/plugins/history.zsh
    echo "# END - Command completion with arrow-key" >> ~/.zsh/plugins/history.zsh
fi

if [[ $INSTALL_SDKMAN == true || $MINIMAL_INSTALL == false ]]; then
    echo "#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!" >> ~/.zshrc
    echo "export SDKMAN_DIR=\"\$HOME/.sdkman\"" >> ~/.zshrc
    echo "[[ -s \"\$HOME/.sdkman/bin/sdkman-init.sh\" ]] && source \"\$HOME/.sdkman/bin/sdkman-init.sh\""
    echo -en '\n' >> ~/.zshrc

    if [ -d ~/.sdkman ]; then
        echo "Sdkman is already installed."
    else
	curl -s "https://get.sdkman.io?rcupdate=false" | bash
    fi
fi
