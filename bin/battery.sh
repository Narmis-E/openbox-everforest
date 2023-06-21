#!/bin/bash
#
battery=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)
if [ $battery -le 5 ]; then
  battery_icon=""
elif [[ $battery -le 25 ]]; then
  battery_icon=""
elif [[ $battery -le 50 ]]; then
  battery_icon=""
elif [[ $battery -le 75 ]]; then
  battery_icon=""
else
  battery_icon=""
fi

if [ $battery == "100" ] ; then
  notify-send "Battery: $status" "Battery Full! ($battery% $battery_icon )"
elif [[ $battery -lt 10 ]]; then
  notify-send "Battery: $status" "Battery Low! ($battery% $battery_icon )"
else
  notify-send "Battery: $status" "$battery% $battery_icon"
fi
