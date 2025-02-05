#!/bin/sh

# Linux post-installation setup

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

install_pacman_packages()
{
    for pack in ${PACMAN_PACKAGES[@]}; do
        pacman -Suy --noconfirm --needed --quiet $pack
    done
}

install_yay()
{
    cd ~
    git clone https://aur.archlinux.org/yay.git
    cd yay
    -u $SUDO_USER makepkg -sir
    cd ..
    rm -rf yay/
    for pack in ${AUR_PACKAGES[@]}; do
        -u $SUDO_USER yay -S --noconfirm --needed --quiet $pack
    done
}

enable_autologin() # TODO - REMAKE WITH CURL OR WGET
{
    cd /
    local getty_path="etc/systemd/system/getty@tty1.service.d"
    cp $getty_path/override.conf /$getty_path/
    sed -i "s/username/$SUDO_USER/" /$getty_path/override.conf
    echo "Autologin is enabled"
}

enable_hyprland_autostart() # TODO - REMAKE!
{
    cp .zprofile ~/
}

install_outline_CLI()
{
    cd ~
    git clone https://github.com/Kir-Antipov/outline-cli
    cd outline-cli
    ./install.sh -y
    cd ..
    rm -rf outline-cli
}

main()
{

    echo "All done"
}

main
