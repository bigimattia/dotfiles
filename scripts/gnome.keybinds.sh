#!/bin/bash

set_shortcut() {
  workspace=$1
  shortcut=$2
  move_shortcut=$3
  if [[ $workspace -eq 10 ]]; then
    shortcut="['<Super>0']"
    move_shortcut="['<Shift><Super>0']"
  fi
  gsettings set org.gnome.desktop.wm.keybindings "switch-to-workspace-$workspace" "$shortcut"
  gsettings set org.gnome.desktop.wm.keybindings "move-to-workspace-$workspace" "$move_shortcut"
  if [[ $workspace -lt 10 ]]; then
    gsettings set org.gnome.shell.keybindings "switch-to-application-$workspace" "[]"
  fi
}

read -p "Do you want to set GNOME workspace keybinds (Switch: <Super>+<n>; Move window to: <Super>+<shift>+<n>)? (y/n): " response
if [[ "$response" == "y" ]]; then
    echo "setting keybinds to  || workspace -> <Super>+$i || move-window-to-workspace -> <Shift><Super>+$i  ||  i=10 will be set to 0";
    for i in {1..10}; do
        set_shortcut $i "['<Super>$i']" "['<Shift><Super>$i']"
    done

    echo "Workspaces keybinds correctly set!"
else
    echo "Keybinds not set."
fi


read -p "Do you want to remove display <Super>+<P> binding (this usually breaks workflow pretty badly, media key will keep working as usual)? (y/n): " displayBindResponse
if [[ "$displayBindResponse" == "y" ]]; then
    gsettings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"

    echo "Workspaces keybinds correctly set!"
else
    echo "Keybinds not set."
fi