#!/bin/sh

#################################################
# Linux post installation configuration
#################################################

if (( $EUID == 0 )); then
	echo -e "Please DON'T run as root/sudo\nExitting..."
	exit
fi

REPO_URL="https://github.com/herm1t0/arch-niri-config"

SOURCES_LIST=(
	$REPO_URL/blob/main/pacman-packages?raw=true
	$REPO_URL/blob/main/aur-packages?raw=true
	$REPO_URL/blob/main/functions?raw=true
)

# Key - url to config, value - config destination
declare -A CONFIG_LIST=(
	["$REPO_URL/blob/main/config/.zprofile?raw=true"]="$HOME/.zprofile"
	["$REPO_URL/blob/main/config/.zshrc?raw=true"]="$HOME/.zshrc"
	["$REPO_URL/blob/main/config/niri/config.kdl?raw=true"]="$HOME/.config/niri/config.kdl"
	["$REPO_URL/blob/main/config/fuzzel/fuzzel.ini?raw=true"]="$HOME/.config/fuzzel/fuzzel.ini"
	["$REPO_URL/blob/main/config/fuzzel/theme.ini?raw=true"]="$HOME/.config/fuzzel/theme.ini"
)

# Include all sources
for source in ${SOURCES_LIST[@]}; do
	source <(curl -Ls $source)
done

#install_packages
install_configs

echo "Jobs done"
