#!/bin/bash
#sudo apt install linux-oem-24.04

BAT_STATUS="/sys/class/power_supply/BAT0/status"
BAT_CAPACITY="/sys/class/power_supply/BAT0/capacity"

HIGH_LIMIT=80
LOW_LIMIT=25

NOTIFIED_HIGH=0
NOTIFIED_LOW=0

while true; do
    status=$(cat "$BAT_STATUS")
    percent=$(cat "$BAT_CAPACITY")


    if [[ "$status" == "Charging" && $percent -ge $HIGH_LIMIT && $NOTIFIED_HIGH -eq 0 ]]; then
        zenity --warning \
            --title="⚡ هشدار شارژ باتری" \
            --width=600 --height=300 \
            --text="شارژ باتری به ${percent}٪ رسیده است!\n\nلطفا لپ‌تاپ را از شارژ بکشید 🚫🔌" &
        NOTIFIED_HIGH=1
        NOTIFIED_LOW=0
    fi


    if [[ "$status" == "Discharging" && $percent -le $LOW_LIMIT && $NOTIFIED_LOW -eq 0 ]]; then
        zenity --error \
            --title="🔋 باتری در حال تخلیه است!" \
            --width=600 --height=300 \
            --text="شارژ باتری فقط ${percent}٪ باقی‌مانده!\n\nلطفا شارژر را وصل کنید ⚡🔌" &
        NOTIFIED_LOW=1
        NOTIFIED_HIGH=0
    fi


    if [[ $percent -lt $(($HIGH_LIMIT-5)) ]]; then
        NOTIFIED_HIGH=0
    fi
    if [[ $percent -gt $(($LOW_LIMIT+5)) ]]; then
        NOTIFIED_LOW=0
    fi

    sleep 30
done

