#! /bin/bash
if [[ -f /sys/class/power_supply/BAT0/current_now ]] || [[ -f /sys/class/power_supply/BAT1/current_now ]]; then
  cat /sys/class/power_supply/BAT*/current_now /sys/class/power_supply/BAT*/voltage_now | xargs | awk '{print $1*$2/1e12 " W"}'
fi
if [[ -f /sys/class/power_supply/BAT0/power_now ]] || [[ -f /sys/class/power_supply/BAT1/power_now ]]; then
  cat /sys/class/power_supply/BAT*/power_now | xargs | awk '{print $1/1e6" W"}'
fi
