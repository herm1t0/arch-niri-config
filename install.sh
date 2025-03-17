#!/bin/sh

#################################################
# Linux post installation configuration
#################################################

REPO_URL="https://github.com/herm1t0/arch-niri-config/blob/main"

SCRIPT_NAME="${0}"

SOURCES_LIST=(
	$REPO_URL/pacman-packages?raw=true
	$REPO_URL/aur-packages?raw=true
	$REPO_URL/functions?raw=true
)

# Key - url to config, value - config destination
declare -A CONFIG_LIST=(
	["$REPO_URL/config/.zprofile?raw=true"]="$HOME/.zprofile"
	["$REPO_URL/config/.zshrc?raw=true"]="$HOME/.zshrc"
	["$REPO_URL/config/niri/config.kdl?raw=true"]="$HOME/.config/niri/config.kdl"
	["$REPO_URL/config/alacritty/alacritty.toml?raw=true"]="$HOME/.config/alacritty/alacritty.toml"
	["$REPO_URL/config/fuzzel/fuzzel.ini?raw=true"]="$HOME/.config/fuzzel/fuzzel.ini"
	["$REPO_URL/config/fuzzel/theme.ini?raw=true"]="$HOME/.config/fuzzel/theme.ini"
)


# Main entry point of the script
main()
{
	# Include all sources
	for source in ${SOURCES_LIST[@]}; do
		source <(curl -Ls $source)
	done

	# Check is script running as root
	assert_is_root

	case "${1}" in
		-i|--install)
			install_packages; install_configs;;
		-u|--update)
			echo -e "NOT IMPLEMENTED YET\n"; show_help; exit;;
		-h|--help)
			show_help; exit;;
		*)
			echo -e "Incorrect input\n"; show_help; exit;;
	esac
	
	echo "Jobs done"	
}

main "${@}"



