# Install flatpak apps
flatpak_apps=(
    org.mozilla.firefox # browser
    org.gnome.TextEditor # text editor
    org.gnome.Showtime # videos
    org.gnome.Decibels # audio
    org.gnome.Loupe # images
    org.mozilla.Thunderbird # mail / calendar
    org.libreoffice.LibreOffice # office suite
)

user_flatpak_apps=(
    com.github.tchx84.Flatseal
    org.fedoraproject.MediaWriter
    org.gimp.GIMP
    org.kde.kdenlive
    com.valvesoftware.Steam
    com.discordapp.Discord
    org.localsend.localsend_app
    com.spotify.Client
    com.bitwarden.desktop
    com.visualstudio.code
    com.heroicgameslauncher.hgl
    com.google.Chrome
)

echo "Do you want to install default apps as Flatpak? (y/n)"
read -r install_flatpaks
if [[ "$install_flatpaks" == "y" ]]; then
    for app in "${flatpak_apps[@]}"; do
        flatpak install --system flathub "$app" -y
    done
fi

echo "Do you want to install the extra user apps as Flatpak? (y/n)"
read -r install_user_flatpak_apps
if [[ "$install_user_flatpak_apps" == "y" ]]; then
    for user_app in "${user_flatpak_apps[@]}"; do
        flatpak install --user flathub "$user_app" -y
    done
fi
