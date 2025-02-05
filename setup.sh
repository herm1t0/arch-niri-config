#!/bin/sh

# Linux post-installation setup

repo_url="https://github.com/herm1t0/arch-hyprland-setup"



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
MISC_PACKAGES="dconf-editor font-manager git linux-headers polkit uwsm file-roller pavucontrol xdg-desktop-portal-hyprlandxdg-desktop-portal-gtk hyprpolkitagent qt5-wayland qt6-wayland hyprland-qt-support"

#AUR_PACKAGES
GUI_TEXT_EDITOR="visual-studio-code-bin"
AUR_MISC_PACKAGES=""


PACMAN_PACKAGES=(
    $SHELL $WAYLAND_COMPOSITOR $CLI_TEXT_EDITOR $FONTS $GPU_DRIVER_PACKAGES $TERMINAL_EMULATOR
	$BROWSER $APP_LAUNCHER $FILE_MANAGER $MISC_PACKAGES
)

AUR_PACKAGES=(
    $GUI_TEXT_EDITOR $AUR_MISC_PACKAGES
)

install_pacman_packages()
{
    echo "Now installing pacman packages..."
    for pack in ${PACMAN_PACKAGES[@]}; do
        pacman -Suy --noconfirm --needed --quiet $pack
    done
}

install_yay()
{
	echo "Now installing yay..."
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

install_aur_packages()
{
	install_yay
	
	echo "Now installing aur packages..."
    for pack in ${AUR_PACKAGES[@]}; do
        -u $SUDO_USER yay -S --noconfirm --needed --quiet $pack
    done
}

enable_autologin()
{
    local getty_path="/etc/systemd/system/getty@tty1.service.d"
	curl -Ls $repo_url/blob/main$getty_path/override.conf?raw=true -o $getty_path/override.conf
    sed -i "s/username/$SUDO_USER/" $getty_path/override.conf
    echo "Autologin is enabled"
}

enable_hyprland_autostart()
{
	curl -Ls $repo_url/blob/main/.zprofile?raw=true -o ~/.zprofile
	echo "Hyprland autostart is enabled"
}

install_outline_CLI()
{
	echo "Now installing outline vpn..."
    curl -Ls https://github.com/Kir-Antipov/outline-cli/blob/master/install.sh?raw=true | sudo bash -s -- -y
}

post_install_configuration()
{
	enable_autologin
	enable_hyprland_autostart
	
	curl -Ls $repo_url/blob/main/config/hypr/hyprland.conf?raw=true -o ~/.config/hypr/hyprland.conf
	
	systemctl --user enable --now hyprpolkitagent.service
}

main()
{
    install_pacman_packages
	install_aur_packages
	install_outline_CLI
	post_install_configuration
	
    echo "All done"
}

main
