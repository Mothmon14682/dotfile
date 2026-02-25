#!/usr/bin/env bash

selected=$(printf "󰐥\n󰜉\n󰒲\n󰿅" | rofi -config ~/.config/rofi/powermenu.rasi -dmenu)

case "$selected" in
    "󰐥")
        poweroff
        ;;
    "󰜉")
        reboot
        ;;
    "󰿅")
        niri msg action quit
        ;;
    "󰒲")
        systemctl suspend
        ;;
    *)
        exit 0
        ;;
esac
