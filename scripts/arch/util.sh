# Function to install packages with either yay or paru
install_package() {
  # TODO 
  if pacman -Q "$1" &>/dev/null ; then
    echo -e "$1 is already installed. Skipping..."
  else
    stdbuf -oL sudo pacman -S --noconfirm "$1"
    # Double check if package is installed
    if pacman -Q "$1" &>/dev/null ; then
      echo -e "Package $1 has been successfully installed!"
    else
      echo -e "\n $1 failed to install. You may need to install manually."
    fi
  fi
}

    
