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


echo "# zsh-autosuggestions" >> ~/.zsh/plugins.zsh
echo "source \$ZSH/plugins/zsh-autosuggestions.zsh" >> ~/.zsh/plugins.zsh

if [ -d ~/.zsh/zsh-autosuggestions ]; then
    echo "zsh-autosuggestions is already installed."
else
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

# Ask to install mise
echo "Do you want to install mise? (y/n)"
read -r install mise
if [[ "$install_mise" == "y" ]]; then
    curl https://mise.run | sh
    echo "# mise" >> ~/.zsh/plugins.zsh
    echo "eval \"\$(/~/.local/bin/mise activate zsh)\"" >> ~/.zsh/plugins.zsh
fi

# toolbox only examples
# echo '# nvm (toolbox only)' >> ~/.zsh/plugins.zsh
# echo 'if [[ -n "$TOOLBOX_CONTAINER" ]]; then' >> ~/.zsh/plugins.zsh
#     # echo '  source "$ZSH/plugins/nvm.zsh"' >> ~/.zsh/plugins.zsh
#     echo "# mise" >> ~/.zsh/plugins.zsh
#     echo "eval \"\$(/~/.local/bin/mise activate zsh)\"" >> ~/.zsh/plugins.zsh
# echo 'fi' >> ~/.zsh/plugins.zsh

# Ask to setup Bitwarden ssh agent (flatpak)
echo "Do you want to setup Bitwarden ssh agent (flatpak) ? (y/n)"
read -r bitwarden_ssh_agent
if [[ "$bitwarden_ssh_agent" == "y" ]]; then
    echo "# Bitwarden ssh agent - Flatpak"  >> ~/.zsh/exports.zsh
    echo "export SSH_AUTH_SOCK=~/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock"  >> ~/.zsh/exports.zsh
fi
