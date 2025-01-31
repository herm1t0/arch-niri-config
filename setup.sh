#!/bin/sh

# Linux post-installation setup

# Right now it only works with arch64 and nvidia GPU!

#################################################
# Packages to install.
#################################################

SHELL="zsh"
WAYLAND_COMPOSITOR="hyprland"
CLI_TEXT_EDITOR="micro"

FONTS="ttf-noto-nerd ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols"
GPU_DRIVER_PACKAGES="nvidia-open-dkms nvidia-utils"
TERMINAL_EMULATOR="alacritty"
BROWSER="firefox"
APP_LAUNCHER="fuzzel"
FILE_MANAGER="nemo"
SOUND_MIXER="pavucontrol"
MISC_PACKAGES="dconf-editor font-manager git linux-headers polkit"

#AUR_PACKAGES
GUI_TEXT_EDITOR="visual-studio-code-bin"
AUR_PACKAGES="uwsm"


PACMAN_PACKAGES=(
    

)

AUR_PACKAGES=(


)

CWD="${PWD}" # Save cloned directory

for pack in ${PACMAN_PACKAGES[@]}; do
    pacman -Suy --noconfirm --needed --quiet $pack
done

# Install yay
read -p "Install AUR helper? (yay) (Y/N): " user_input

if [[ $user_input == "y" || $user_input == "Y" ]] 
then
    cd ~
    git clone https://aur.archlinux.org/yay.git
    cd yay
    -u $SUDO_USER makepkg -sir
    cd ..
    rm -rf yay/
    for pack in ${AUR_PACKAGES[@]}; do
        -u $SUDO_USER yay -S --noconfirm --needed --quiet $pack
    done
else
    echo "yay and AUR packages won't be installed"
fi

# Enable tty autologin
read -p "Enable tty autologin for the current user? (Y/N): " user_input

if [[ $user_input == "y" || $user_input == "Y" ]] 
then
cd $CWD # Back to the main directory
getty_path="etc/systemd/system/getty@tty1.service.d"
cp $getty_path/override.conf /$getty_path/
sed -i "s/username/$SUDO_USER/" /$getty_path/override.conf
echo "Autologin is enabled"
fi

# Enable hyprland autostart
read -p "Launch hyprland on startup? (Y/N): " user_input

if [[ $user_input == "y" || $user_input == "Y" ]] 
then
cp .zprofile ~/
fi

# Install outline VPN
read -p "Install Outline CLI? (Y/N): " user_input

if [[ $user_input == "y" || $user_input == "Y" ]] 
then
cd ~
git clone https://github.com/Kir-Antipov/outline-cli
cd outline-cli
./install.sh -y
cd ..
rm -rf outline-cli
fi

echo "All done :)"
