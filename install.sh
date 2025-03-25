#!/bin/bash

#################################################
# Linux post installation configuration
#################################################

REPO_URL="https://github.com/herm1t0/arch-niri-config/blob/main"

export SCRIPT_NAME="${0}"

SOURCES_LIST=(
	"$REPO_URL/pacman-packages?raw=true"
	"$REPO_URL/aur-packages?raw=true"
	"$REPO_URL/functions?raw=true"
)

# Key - url to config, value - config destination
declare -Ax CONFIG_LIST=(
	["$REPO_URL/config/.zshenv?raw=true"]="$HOME/.zshenv"
	["$REPO_URL/config/zsh/.zprofile?raw=true"]="$HOME/.config/zsh/.zprofile"
	["$REPO_URL/config/zsh/.zshrc?raw=true"]="$HOME/config/zsh/.zshrc"
	["$REPO_URL/config/niri/config.kdl?raw=true"]="$HOME/.config/niri/config.kdl"
	["$REPO_URL/config/fuzzel/fuzzel.ini?raw=true"]="$HOME/.config/fuzzel/fuzzel.ini"
	["$REPO_URL/config/fuzzel/theme.ini?raw=true"]="$HOME/.config/fuzzel/theme.ini"
)

read_input()
{
	printf "%s" "Choose an option:\n1 - install\n2 - update\n3 - show info\n"
	read -r input
}

# Main entry point of the script
main()
{
	echo "0005"
	read_input

	# Include all sources
	for source in "${SOURCES_LIST[@]}"; do
		source <(curl -Ls "$source")
	done

	# Check is script running as root
	assert_is_root

	

	case "${input}" in
		1|install)
			install_packages; install_configs;;
		2|update)
			echo -e "NOT IMPLEMENTED YET\n"; exit;;
		3|info)
			show_info; exit;;
		*)
			echo -e "Incorrect input\n"; exit;;
	esac
	
	echo "Jobs done"	
}

main