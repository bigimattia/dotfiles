cp .zshrc ~/
cp -r .zsh ~/.zsh

read -p "Do you want a minimal install? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    > ~/.zsh/plugin.zsh

    read -p "Do you want to install autosuggestions? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

        echo "#zsh-autosuggestions" > ~/.zsh/plugin.zsh
        echo "source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh" > ~/.zsh/plugin.zsh
    fi

    read -p "Do you want to install nvm? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'

        echo "#nvm" > ~/.zsh/plugin.zsh
        echo "export NVM_DIR=\"$HOME/.nvm\"" > ~/.zsh/plugin.zsh
        echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\" # This loads nvm" > ~/.zsh/plugin.zsh
        echo "[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\"  # This loads nvm bash_completion" > ~/.zsh/plugin.zsh
    fi
else
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
fi
