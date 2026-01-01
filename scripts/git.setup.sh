# Ask if the user wants to set up git
echo "Do you want to set up git? (y/n)"
read -r setup_git
if [[ "$setup_git" == "y" ]]; then
    echo "Enter your git email:"
    read -r git_email
    echo "Enter your git username:"
    read -r git_username
    echo "Enter git hostname (empty for: github.com):"
    read -r git_hostname
    git_hostname=${git_hostname:-github.com}
    echo "Enter ssh filename (empty for: id_ed25519_personal):"
    read -r ssh_filename
    ssh_filename=${ssh_filename:-id_ed25519_personal}

    git config --global user.email "$git_email"
    git config --global user.name "$git_username"

    ssh-keygen -t ed25519 -C "$git_email" -f ~/.ssh/"$ssh_filename"

    #copy default setup
    if [ -d dotfiles/.ssh ]; then
        cp -r dotfiles/.ssh ~/
    else
        echo "Directory .ssh does not exist."
    fi

    echo "# Personal account" >> ~/.ssh/config
    echo "Host $git_hostname" >> ~/.ssh/config
    echo "HostName $git_hostname" >> ~/.ssh/config
    echo "User $git_username" >> ~/.ssh/config
    echo "IdentityFile ~/.ssh/$ssh_filename" >> ~/.ssh/config
    echo "IdentitiesOnly yes" >> ~/.ssh/config

    echo "Add the following SSH key to your GitHub (or whatever else) account:"
    cat ~/.ssh/$ssh_filename.pub

    echo "Press any key to continue..."
    read -n 1 -s
fi
