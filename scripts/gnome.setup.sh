#!/bin/bash

# Ask if the user wants to set GNOME keybinds
echo "Do you want to set GNOME keybinds? (y/n)"
read -r set_gnome_keybinds
if [[ "$set_gnome_keybinds" == "y" ]]; then
    runScript scripts/gnome.keybinds.sh
fi