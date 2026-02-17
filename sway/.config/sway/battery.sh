#!/bin/bash

prev_status=""
notified=false

while true; do
    status=$(cat /sys/class/power_supply/BAT0/capacity_level)
    charging=$(cat /sys/class/power_supply/BAT0/status)

    # Reset notification flag when charging
    if [ "$charging" = "Charging" ]; then
        notified=false
    fi

    # Trigger only on low → critical and if not notified yet
    if [ "$prev_status" = "Normal" ] && [ "$status" = "Low" ] && [ "$notified" = false ]; then
        notify-send \
            --app-name="Battery" \
            --icon="/usr/share/icons/Adwaita/symbolic/status/battery-level-0-symbolic.svg" \
            --urgency="critical" \
            "Battery is running out" \
            "You should plug in to continue using"
        notified=true
    fi

    prev_status="$status"
    sleep 15
done
