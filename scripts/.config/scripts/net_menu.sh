#!/usr/bin/env bash

rofi_selection() {
    rofi -dmenu -theme-str "textbox-prompt-colon { 
                                str: '$1'; 
                                padding: 10px 14px 10px 14px; 
                            }
                            
                            entry {
                                placeholder: '$2';
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

wifi_connect() {
    nmcli device wifi rescan

    connected=$(nmcli -t -f NAME connection show)
    selection=$(nmcli -t -f SECURITY,SSID,SIGNAL device wifi list | 
                sort -t: -k3 -nr | 
                awk -F: '$2 != "" { print $1 ":" $2 }' |
                awk -F: '!seen[$2]++' |
                sed -E 's/^[^:]+:/ /' | 
                sed -E 's/^:/ /' | 
                rofi_selection 'SSID:' 'Amiya, connect to this wifi...')

    if [[ -z "$selection" ]]; then
        return 0
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
}

wifi_forget() {
    ssid=$(nmcli -t -f NAME,TYPE connection show | awk -F: '$2 == "802-11-wireless" { print $1 }' | rofi_selection "Forget:" "Don't forget me...")

    if [[ -z "$ssid" ]]; then
        return 0
    fi

    nmcli connection delete "$ssid"
    status=$?
    check_and_notify $status "Forgot the wifi name $ssid" "Wifi to strong to forget"
}

wifi_action() {
    selection=$(printf "󱛅 Forgot Wifi\n󱚽 Connect Wifi" | rofi_selection "Action:" "Where is Amiya?")
    
    if [[ -z $selection ]]; then
        exit 0
    fi

    if [[ "$selection" =~ "󱛅" ]]; then
        wifi_forget
    elif [[ "$selection" =~ "󱚽" ]]; then
        wifi_connect
    fi
}

while true; do
    wifi_action
done
