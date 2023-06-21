#!/bin/sh
set -eu
# You can call this script like this:
# $./brightness.sh up
# $./brightness.sh down

# icon
brightness_icon_high="display-brightness-high-symbolic"
brightness_icon_medium="display-brightness-medium-symbolic"
brightness_icon_low="display-brightness-low-symbolic"

get_brightness () {
    b=$(light | grep -oE '^[0-9]+')
}

send_notification () {
	# Send the notification
    dunstify -i "$brightnessicon" -t 1600 -h string:x-dunst-stack-tag:brightness -u normal "Brightness" -h int:value:"$b"
}
brightness_check () {
    get_brightness
    if [ "$b" -ge 70 ]; then
        brightnessicon="$brightness_icon_high"
        changevalue="10"
    elif [ "$b" -ge 50 ]; then
        brightnessicon="$brightness_icon_medium"
    	changevalue="10"
    elif [ "$b" -ge 10 ]; then
        brightnessicon="$brightness_icon_low"
    	changevalue="5"
    elif [ "$b" -ge 5 ]; then
	brightnessicon="$brightness_icon_low"
        changevalue="2"
    else
        brightnessicon="$brightness_icon_low"
    	changevalue="1"
    fi
}
case $1 in
    up)
	brightness_check
        light -A $changevalue > /dev/null
        send_notification
        ;;
    down)
	brightness_check
        light -U $changevalue > /dev/null
        send_notification
        ;;
esac
