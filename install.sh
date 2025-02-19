cp .zshrc ~/
cp -r .zsh ~/.zsh

MINIMAL_INSTALL=false
INSTALL_AUTOSUGGESTIONS=false
INSTALL_NVM=false

read -p "Do you want a minimal install? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    MINIMAL_INSTALL=true
    > ~/.zsh/plugin.zsh

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
fi

if [[ $INSTALL_AUTOSUGGESTIONS == true || $MINIMAL_INSTALL == false ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    echo "# zsh-autosuggestions" >> ~/.zsh/plugin.zsh
    echo "source \$ZSH/plugins/zsh-autosuggestions.zsh" >> ~/.zsh/plugin.zsh
fi

if [[ $INSTALL_NVM == true || $MINIMAL_INSTALL == false ]]; then
    PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
    echo "# nvm" >> ~/.zsh/plugin.zsh
    echo "source \$ZSH/plugins/nvm.zsh" >> ~/.zsh/plugin.zsh
fi
