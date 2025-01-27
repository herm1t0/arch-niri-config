#!/bin/sh

# Linux post-installation setup

# Right now it only works with arch64 and nvidia GPU!

#################################################
# Packages to install.
#################################################
CLI_MAIN_PACKAGES="git linux-headers polkit"
CLI_TEXT_EDITOR="micro"
FONT_PACKAGES="ttf-noto-nerd ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols"
GPU_DRIVER_PACKAGES="nvidia-open-dkms nvidia-utils"

# Hyprland packages (GUI only) alacritty

HYPR_MAIN_PACKAGES="hyprland"
HYPR_CONSOLE_EMULATOR="alacritty"
HYPR_BROWSER="firefox"
HYPR_APP_LAUNCHER="fuzzel"
HYPR_FILE_MANAGER="nemo"
HYPR_SOUND_MIXER="pavucontrol"
HYPR_MISC_PACKAGES="dconf-editor font-manager"


PACKS_TO_INSTALL=(
    

)




for pack in ${PACKS_TO_INSTALL[@]}; do
    pacman -Suy --noconfirm --needed --quiet $PACKS_TO_INSTALL
done

read -p "Install AUR helper? (yay) (Y/N): " USER_INPUT

if [[ $USER_INPUT == "y" || $USER_INPUT == "Y" ]] 
then
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
-u $USER makepkg -sir
cd ..
rm -rf yay/
fi

read -p "Install Outline CLI? (Y/N): " USER_INPUT

if [[ $USER_INPUT == "y" || $USER_INPUT == "Y" ]] 
then
cd ~
git clone https://github.com/Kir-Antipov/outline-cli
cd outline-cli
./install.sh -y
cd ..
rm -rf outline-cli
fi

echo "All done :)"