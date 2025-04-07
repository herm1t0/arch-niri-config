#!/bin/bash

#################################################
# Linux post installation configuration
#################################################

REPO_URL="https://github.com/herm1t0/arch-niri-config/blob/main"
JETBRA_PATH="$HOME/jetbra"

declare -a SOURCES_LIST=(
	"$REPO_URL/pacman-packages?raw=true"
	"$REPO_URL/aur-packages?raw=true"
	"$REPO_URL/functions?raw=true"
)

# Key - config file URL, value - config file destination path
declare -Ax CONFIG_LIST=(
	["$REPO_URL/config/.zshenv?raw=true"]="$HOME/.zshenv"
	["$REPO_URL/config/zsh/.zprofile?raw=true"]="$HOME/.config/zsh/.zprofile"
	["$REPO_URL/config/zsh/.zshrc?raw=true"]="$HOME/config/zsh/.zshrc"
	["$REPO_URL/config/niri/config.kdl?raw=true"]="$HOME/.config/niri/config.kdl"
	["$REPO_URL/config/fuzzel/fuzzel.ini?raw=true"]="$HOME/.config/fuzzel/fuzzel.ini"
	["$REPO_URL/config/fuzzel/theme.ini?raw=true"]="$HOME/.config/fuzzel/theme.ini"
	["$REPO_URL/jetbra/block_url_keywords?raw=true"]="$JETBRA_PATH/block_url_keywords"
	["$REPO_URL/jetbra/fuzzel/theme.ini?raw=true"]="$JETBRA_PATH/block_url_keywords"
	["$REPO_URL/jetbra/fuzzel/theme.ini?raw=true"]="$JETBRA_PATH/block_url_keywords"
)

# Main entry point of the script
main()
{

	# Include all sources
	for src in "${SOURCES_LIST[@]}"; do
		source <(curl -Ls "$src")
	done

	# Check is script running as root
	assert_is_sudo

	printf "%s\n" "Choose an option:" "1 - install" "2 - update" "3 - show info"
	read -r input

	case "${input}" in
		1|install)
			install_packages; install_configs;;
		2|update)
			printf "%s\n" "NOT IMPLEMENTED YET"; exit;;
		3|"show info"|info)
			show_info; exit;;
		*)
			printf "%s\n" "Incorrect input"; exit;;
	esac
	
	printf "%s\n" "Jobs done, don't forget to reboot"
}

# Calls a main function
main