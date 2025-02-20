source ../util.sh

pipewire=(
    pipewire
    wireplumber
    pipewire-audio
    pipewire-alsa
    pipewire-pulse
)

# Disabling pulseaudio to avoid conflicts and logging output
echo -e "Disabling pulseaudio to avoid conflicts..."
systemctl --user disable --now pulseaudio.socket pulseaudio.service

# Pipewire
echo -e "Installing Pipewire Packages..."
for PIPEWIRE in "${pipewire[@]}"; do
    install_package "$PIPEWIRE"
done

echo -e "Activating Pipewire Services..."
# Redirect systemctl output to log file
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
systemctl --user enable --now pipewire.service

echo -e "\n Pipewire Installation and services setup complete!"

printf "\n%.0s" {1..2}