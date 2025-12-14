echo "Do you want to setup zsh? (y/n)"
read -r install_zsh
if [[ "$install_zsh" == "y" ]]; then
    # Run the install.sh script
    runScript scripts/old-zsh.setup.sh
fi
