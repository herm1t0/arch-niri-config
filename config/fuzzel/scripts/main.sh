#!/bin/bash

declare -x SCRIPTDIR
SCRIPTDIR="$(dirname -- "${BASH_SOURCE[0]}")";

declare -x APPSDIR="$HOME/.local/share/applications"

declare -x DEFAULT_ICON="application-default-icon"
declare -x DEFAULT_ICON_FULL="\0icon\x1fapplication-default-icon"
declare -A MENU_OPTIONS
declare -A MENU_ICONS

# Hardcoded menu icons
MENU_ICONS=(
	#["Applications"]="\0icon\x1ffirefox"
	#["Apps settings"]="\0icon\x1ffirefox"
)

# Menu options to show on launch. Key - string name, value - script path to execute
MENU_OPTIONS=(
	["Applications"]="$SCRIPTDIR/apps-launcher"
	["Apps settings"]="$SCRIPTDIR/apps-settings"
	["System settings"]="$SCRIPTDIR/system-settings"
	["Utils"]="$SCRIPTDIR/utils"
)

# If menu icon is not set(empty) it will use default icon
for item in "${!MENU_OPTIONS[@]}"; do
	if [[ -z "${MENU_ICONS[$item]}" ]]; then
		MENU_ICONS+=(["$item"]="$DEFAULT_ICON_FULL")
	fi
done

user_selection=$(paste <(printf "%s\n" "${!MENU_OPTIONS[@]}") <(printf "%b\n" "${MENU_ICONS[@]}") | fuzzel -d | sed 's/[^a-z  A-Z]//g')
"${MENU_OPTIONS[$user_selection]}"