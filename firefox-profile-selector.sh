#!/usr/bin/env bash

FIREFOX_EXE="/usr/bin/firefox"
PROFILE_DIR="$HOME/.mozilla/firefox/profiles.ini"

PROFILES=()
while IFS='=' read -r key value; do
    case "$key" in
        "[Profile"*) name="" path="" ;;
        "Name") name="$value" ;;
        "Path") path="$value" ;;
    esac
    if [[ -n "$name" && -n "$path" ]]; then
        PROFILES+=("$name" "$path")
        name=""
        path=""
    fi
done < "$PROFILE_DIR"

if [[ ${#PROFILES[@]} -eq 0 ]]; then
    zenity --error --title="Error" --text="No Firefox profiles found!"
    exit 1
fi

SELECTED_PROFILE=$(zenity --list --title="Select Firefox Profile" \
    --column="Profile Name" --column="Profile Path" \
    --width=600 --height=400 "${PROFILES[@]}")

if [[ -n "$SELECTED_PROFILE" ]]; then
    systemd-run --user --scope "$FIREFOX_EXE" -P "$SELECTED_PROFILE" "$@"
    exit 0
else
    exit 1
fi

