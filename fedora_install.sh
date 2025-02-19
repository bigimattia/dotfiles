#!/bin/bash

sudo dnf install zsh -y

# Remove Fedora Flatpak repository if present
flatpak remote-delete fedora

# Add Flathub repository if not already present
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# user as well
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

# Remove Fedora Workstation apps

sudo dnf remove firefox -y
sudo dnf remove libreoffice-core -y
sudo dnf remove fedora-bookmarks -y
sudo dnf remove abrt-desktop -y
sudo dnf remove rhythmbox -y
sudo dnf remove mediawriter -y

# fedora-chromium-config # what is this package ??

sudo dnf remove gnome-weather -y
sudo dnf remove gnome-maps -y
sudo dnf remove gnome-logs -y
sudo dnf remove gnome-boxes -y # no reinstall
sudo dnf remove gnome-connections -y
sudo dnf remove gnome-initial-setup -y
sudo dnf remove gnome-font-viewer -y
sudo dnf remove gnome-characters -y
sudo dnf remove gnome-contacts -y
sudo dnf remove gnome-calendar -y
sudo dnf remove gnome-calculator -y
sudo dnf remove gnome-clocks -y
sudo dnf remove gnome-text-editor -y
sudo dnf remove loupe -y
sudo dnf remove simple-scan -y
sudo dnf remove evince -y
sudo dnf remove baobab -y
sudo dnf remove totem -y

# Install Fedora Workstation apps as Flatpak
flatpak install flathub org.mozilla.firefox -y

flatpak install flathub org.gnome.Weather -y
flatpak install flathub org.gnome.Maps -y
flatpak install flathub org.gnome.Logs -y
flatpak install flathub org.gnome.Contacts -y
flatpak install flathub org.gnome.Calendar -y
flatpak install flathub org.gnome.Calculator -y
flatpak install flathub org.gnome.font-viewer -y
flatpak install flathub org.gnome.Characters -y
flatpak install flathub org.gnome.Clocks -y
flatpak install flathub org.gnome.TextEditor -y
flatpak install flathub org.gnome.Loupe -y
flatpak install flathub org.gnome.SimpleScan -y
flatpak install flathub org.gnome.Papers -y
flatpak install flathub org.gnome.Connections -y
flatpak install flathub org.gnome.baobab -y
flatpak install flathub org.gnome.Showtime -y


# Update the system
sudo dnf upgrade -y