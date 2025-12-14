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

echo '# nvm (toolbox only)' >> ~/.zsh/plugins.zsh
echo 'if [[ -n "$TOOLBOX_CONTAINER" ]]; then' >> ~/.zsh/plugins.zsh
echo '  source "$ZSH/plugins/nvm.zsh"' >> ~/.zsh/plugins.zsh
echo 'fi' >> ~/.zsh/plugins.zsh
