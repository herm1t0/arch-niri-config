#!/bin/sh

#################################################
# Linux post installation configuration
#################################################

repo_url="https://github.com/herm1t0/arch-hyprland-setup"
pacman_packages_url="$repo_url/blob/main/pacman-packages?raw=true"
aur_packages_url="$repo_url/blob/main/aur-packages?raw=true"
functions_url="$repo_url/blob/main/functions?raw=true"

# Load pacman packages list
source <(curl -Ls $pacman_packages_url)
# Load AUR packages list
source <(curl -Ls $aur_packages_url)
# Load functions
source <(curl -Ls $functions_url)

install_pacman_packages
install_aur_packages
install_configs

enable_autologin
enable_niri_autostart

echo "All done"
