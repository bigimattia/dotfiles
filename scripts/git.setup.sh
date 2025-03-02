# Ask if the user wants to set up git
echo "Do you want to set up git? (y/n)"
read -r setup_git
if [[ "$setup_git" == "y" ]]; then
    echo "Enter your git email:"
    read -r git_email
    echo "Enter your git username:"
    read -r git_username

    git config --global user.email "$git_email"
    git config --global user.name "$git_username"

    ssh-keygen -t ed25519 -C "$git_email"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo "Add the following SSH key to your GitHub account:"
    cat ~/.ssh/id_ed25519.pub
    echo "Press any key to continue..."
    read -n 1 -s
fi