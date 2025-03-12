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
	-u $SUDO_USER makepkg -sir --needed --noconfirm
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

    # Copy up-to-date configs from the repo
	curl -Ls $repo_url/blob/main/config/hypr/hyprland.conf?raw=true -o ~/.config/hypr/hyprland.conf # Hyprland
	
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
