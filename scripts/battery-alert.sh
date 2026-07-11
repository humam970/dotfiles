#!/bin/sh

BAT="/sys/class/power_supply/BAT1"
LOW=20
CRITICAL=10

notified_low=0
notified_critical=0

notify-send \
    -a Battery \
    "Battery notifier" \
    "Battery notification service started."

while sleep 120; do
    battery=$(<"$BAT/capacity")
    status=$(<"$BAT/status")

    if [ "$status" = "Discharging" ]; then
        if [ "$battery" -le "$LOW" ] && [ "$notified_low" -eq 0 ]; then
            notify-send \
                -a Battery \
                "Battery low" \
                "Battery at ${battery}%"
            notified_low=1
        fi

        if [ "$battery" -le "$CRITICAL" ] && [ "$notified_critical" -eq 0 ]; then
            notify-send \
                -u critical \
                -a Battery \
                "Battery critical" \
                "Battery at ${battery}%"
            notified_critical=1
        fi
    else
        notified_low=0
        notified_critical=0
    fi

    [ "$battery" -gt "$LOW" ] && notified_low=0
    [ "$battery" -gt "$CRITICAL" ] && notified_critical=0
done
