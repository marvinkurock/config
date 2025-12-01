#!/usr/bin/env bash
if ((EUID != 0)); then
    echo "ERROR: must run as root." >&2
    exit 1
fi

case ${1:?power option required} in
    low|powersave)
        scaling_governor=powersave
        freq_boost=0
        epp=power
        amd_pstate=active
        asusctl profile --profile-set Quiet
        sudo powertop --auto-tune
        ;;
    high|performance)
        scaling_governor=performance
        freq_boost=1
        epp=performance
        amd_pstate=passive
        ;;
esac

tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor <<<"$scaling_governor"
tee /sys/devices/system/cpu/cpufreq/boost <<<$freq_boost
tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference <<<"$epp"
tee /sys/devices/system/cpu/amd_pstate/status <<<"$amd_pstate"

