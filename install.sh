#!/bin/sh

#################################################
# Linux post installation configuration
#################################################

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
	["$REPO_URL/blob/main/config/alacritty/alacritty.toml?raw=true"]="$HOME/.config/alacritty/alacritty.toml"
	["$REPO_URL/blob/main/config/fuzzel/fuzzel.ini?raw=true"]="$HOME/.config/fuzzel/fuzzel.ini"
	["$REPO_URL/blob/main/config/fuzzel/theme.ini?raw=true"]="$HOME/.config/fuzzel/theme.ini"
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

	case ${1} in
		-i|--install)
			install_configs;;
		-u|--update)
			echo "TO DO"; show_help; exit;;
		-h|--help)
			show_help; exit;;
		*)
			echo "incorrect input ${@}"; show_help; exit;;
	esac

	#install_packages
	echo "Jobs done"	
}

main "${@}"



