#!/bin/bash
# TODO : COPY HYPRLAND / WAYBAR / ETC DOTFILES TO HOME DIRECTORY
# copy .config
cp -r dotfiles/.config ~/

# copy .zprofile
if [ -f dotfiles/.zprofile ]; then
    cp dotfiles/.zprofile ~/
else
    echo "File .zprofile does not exist."
fi

# setup .zprofile
read -p "Do you want to default to Hyprland session? (y/n): " default_hyprland
if [[ "$default_hyprland" == "y" ]]; then
    echo '# This will bring uwsm compositor selection menu after you log in tty1. Choose Hyprland entry and you’re good to go.' >> ~/.zprofile
    echo 'if uwsm check may-start; then' >> ~/.zprofile
    echo '    exec uwsm start hyprland.desktop' >> ~/.zprofile
    echo 'fi' >> ~/.zprofile
    echo '' >> ~/.zprofile
    echo '# If you want to bypass compositor selection menu and launch Hyprland directly, use this code in your shell profile, instead.' >> ~/.zprofile
    echo '# if uwsm check may-start && uwsm select; then' >> ~/.zprofile
    echo '#     exec systemd-cat -t uwsm_start uwsm start default' >> ~/.zprofile
    echo '# fi' >> ~/.zprofile
else
    echo '# This will bring uwsm compositor selection menu after you log in tty1. Choose Hyprland entry and you’re good to go.' >> ~/.zprofile
    echo '# if uwsm check may-start; then' >> ~/.zprofile
    echo '#     exec uwsm start hyprland.desktop' >> ~/.zprofile
    echo '# fi' >> ~/.zprofile
    echo '' >> ~/.zprofile
    echo '# If you want to bypass compositor selection menu and launch Hyprland directly, use this code in your shell profile, instead.' >> ~/.zprofile
    echo 'if uwsm check may-start && uwsm select; then' >> ~/.zprofile
    echo '    exec systemd-cat -t uwsm_start uwsm start default' >> ~/.zprofile
    echo 'fi' >> ~/.zprofile
fi