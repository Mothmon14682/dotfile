#!/usr/bin/env bash

rofi_selection() {
    rofi -dmenu -theme-str "textbox-prompt-colon { 
                                str: '$1'; 
                                padding: 10px 14px 10px 14px; 
                            }
                            
                            entry {
                                placeholder: 'Amiya, find me this wifi...';
                            }
                           "
}

rofi_password() {
    rofi -dmenu -password -theme-str "textbox-prompt-colon { 
                                str: 'Password:'; 
                                padding: 10px 14px 10px 14px; 
                            }
                            
                            entry {
                                placeholder: 'Don't tell Kal\'sit this...';
                            }
                            
                            mainbox {
                                children: [ 'inputbar' ];
                            }
                           "
}

check_and_notify() {
    local status=$1

    if [[ $status -eq 0 ]]; then
        notify-send "Net menu" "$2" -u low -t 5000 -r 80211
        exit 0
    else
        notify-send "Net menu" "$3" -u critical -t 0 -r 80211
    fi
}

while true; do
    nmcli device wifi rescan

    connected=$(nmcli -t -f NAME connection show)
    selection=$(nmcli -t -f SECURITY,SSID device wifi list | sort -u | awk -F: '$2 != ""' | sed -E 's/^[^:]+:/ /' | sed -E 's/^:/ /' | rofi_selection 'SSID:')

    if [[ -z "$selection" ]]; then
        exit 0
    fi

    if [[ "$selection" == *""* ]]; then
        ssid=${selection# }
        security=1
    elif [[ "$selection" == *""* ]]; then
        ssid=${selection# }
        security=0
    fi


    if [[ "$connected" =~ "$ssid" ]]; then
        nmcli connection up "$ssid"
        status=$?
        check_and_notify $status "Successfully bring $ssid up" "Failed to bring $ssid up"
    elif [[ $security -eq 1 ]]; then
        password=$(rofi_password)

        if [[ -z $password ]]; then
            continue
        fi

        nmcli device wifi connect "$ssid" password "$password"
        status=$?
        check_and_notify $status "Successfully connected to $ssid" "Failed to connect to $ssid"
    elif [[ $security -eq 0 ]]; then
        nmcli device wifi connect "$ssid"
        status=$?
        check_and_notify $status "Successfully connected to $ssid" "Failed to connect to $ssid"
    fi
done
