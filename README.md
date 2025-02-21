# Dotfiles

This project contains a collection of my personal dotfiles and configuration scripts to set up a custom installation that suits my needs.

The install scripts are ment to rapidly configure a new install to suits my needs.

Actual dotfiles are stored in the ```/dotfiles``` folder

### fedora workstation post-install script

- set ```<Super>+<number>``` to switch workspaces 
- set ```<Super>+<shift>+<number>``` to move active window to workspace
- remove fedora flatpak and add flathub
- remove gnome apps installed from dnf and reinstall them as flatpak
- install zsh with starship (optional) and FiraCodeNerdFont
- "fix" 65% keyboard layout Fn
- prompt to setup git ssh and guide you
- enable bluetooth multiprofile (please do so only if your hardware supports it)
- [NOT OPTIONAL] upgrade the packages
- reboot

## Disclaimer

**Disclaimer:** Use these scripts at your own risk. The author is not responsible for any damage or data loss that may occur as a result of using these scripts. Always review the code and understand what it does before executing it on your machine.

## Cloning the Repository

To clone this repository, run the following command:

```sh
git clone https://github.com/bigimattia/dotfiles.git
cd dotfiles
```

## Running Install Scripts

To run the install scripts, execute the following command:

### fedora:
```sh
chmod +x fedora_install.sh
./fedora_install.sh
```

### arch (minimal install):
```sh
# Work in progress
```

This will set up your environment according to the configurations specified in the repository.