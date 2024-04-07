#!/bin/bash

#how many percentage from number
calculate_percentage() {
    local number="$1"
    local percentage="$2"
    echo "$(( (number * percentage) / 100 ))"
}

function get_random_number() {
    if [ "$#" -eq 0 ]; then
        start_rnd=1
        end_rnd=10
        random_number=$(( RANDOM % (end_rnd - start_rnd + 1) + start_rnd ))
        echo "$random_number"
    elif [ "$#" -eq "2" ]; then
        start_rnd=$1
        end_rnd=$2
        random_number=$(( RANDOM % (end_rnd - start_rnd + 1) + start_rnd ))
        echo "$random_number"
    else
        echo "Wrong arguments in get_random_number function."
        exit 1
    fi
}

function calc_damage() {
    local weapon_dmg=$1
    local per=$2
    local str=$3
    local base_dmg=$((weapon_dmg + str))
    local random_modifier=$(get_random_number -$((per / 3)) $((per / 3)))
    local critical_chance=$(get_random_number 1 100)
    
    if [ $critical_chance -le $per ]; then
        base_dmg=$((base_dmg * 2))
    fi
    
    local final_dmg=$((base_dmg + random_modifier))
    final_dmg=$((final_dmg > 0 ? final_dmg : 0))
    
    echo $final_dmg
}