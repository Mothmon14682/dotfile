#!/usr/bin/env bash

connected=$(nmcli -t -f NAME connection show)
selection=$(nmcli -t -f SECURITY,SSID device wifi | sort -u | sed -E 's/(WPA)\S//g; s/ //g; /:[[:space:]]*$/d; s/:/ /' | rofi -dmenu -p "SSID: ")
ssid=${selection# }

success="Connected to: $ssid"

if [[ -z "$selection" ]]; then
    exit 0
elif [[ "$selection" =~ "" ]]; then
    pass=$(rofi -dmenu -password -p "Password: ")

    if [[ -z "$pass" ]]; then
        notify-send -u critical "Net Menu" "Need to pass in a password to connect"
        exit 1
    fi

    if echo "$connected" | grep -Fxq "$ssid"; then
        if nmcli connection up "$ssid" > /dev/null; then
            notify-send -u normal "Net Menu" "$success"
            exit 0
        else
            notify-send -u critical "Net Menu" "Connection failed"
        fi

    else
        if nmcli device wifi connect "$ssid" password "$pass" > /dev/null; then
            notify-send -u normal "Net Menu" "$success"
            exit 0
        else
            notify-send -u critical "Net Menu" "Failed to connect to $ssid"
            nmcli connection delete "$ssid"
        fi
    fi
else
    if echo "$connected" | grep -Fxq "$ssid"; then
        if nmcli connection up "$ssid" > /dev/null; then
            notify-send -u normal "Net Menu" "$success"
            exit 0
        else
            notify-send -u critical "Net Menu" "Connection failed"
        fi

    else
        if nmcli device wifi connect "$ssid" > /dev/null; then
            notify-send -u normal "Net Menu" "$success"
            exit 0
        else
            notify-send -u critical "Net Menu" "Failed to connect to $ssid"
            nmcli connection delete "$ssid"
        fi
    fi
fi
