#!/bin/bash

echo "This script will remove and lock several KDE packages and patterns to prevent reinstallation."
echo "Do you wish to continue? (y/n)"
read -r response
if [[ "$response" != "y" ]]; then
    echo "Operation cancelled."
    exit 1
fi

#TODO : improve detection / handling of packages

# Install patterns
sudo zypper install -t pattern base enhanced_base kde_plasma selinux

# Lock patterns
sudo zypper al -t pattern kde_yast patterns-base-x11 plasma6-session-x11 yast2_basis
sudo zypper al patterns-base-x11 plasma6-session-x11

# Install extra packages
sudo zypper install ark btrfsprogs chrony cryptsetup device-mapper discover6 \
    dosfstools dracut e2fsprogs firewalld flatpak git-core glibc irqbalance \
    kernel-default kexec-tools myrlyn NetworkManager numactl nvme-cli \
    partitionmanager plasma-framework-lang plasma6-workspace-lang rpm sdbootutil \
    selinux-policy-targeted-gaming shim snapper spectacle systemd-boot \
    systemsettings6-lang zsh tar

# Configure SDDM for Wayland on openSUSE Tumbleweed KDE

# Create/edit SDDM Wayland configuration
sudo tee /etc/sddm.conf.d/10-wayland.conf > /dev/null <<EOF
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell

[Wayland]
CompositorCommand=kwin_wayland --drm --no-lockscreen
EOF

# Enable SDDM service (use force to override the legacy one)
sudo systemctl enable --force sddm

echo "SDDM Wayland configuration completed"


