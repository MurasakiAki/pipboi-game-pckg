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

function get_random_name() {
    local enemy_name_file="../enemies/names.txt"
    if [ -f "$enemy_name_file" ]; then
        local random_name=$(shuf -n 1 "$enemy_name_file" | cut -d "|" -f 1)
        echo "$random_name"
    else
        echo "Enemy name file doesn't exist."
        exit 1
    fi
}

function get_description() {
    local enemy_name_file="../enemies/names.txt"
    if [ -f "$enemy_name_file" ]; then
        local description=$(grep "^$1" "$enemy_name_file" | cut -d "|" -f 2- | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
        echo "$description"
    else
        echo "Enemy name file doesn't exist."
        exit 1
    fi
}

function get_random_wpn_name() {
    local wpn_name_file="../weapons/names.txt"
    if [ -f "$wpn_name_file" ]; then
        local random_name=$(shuf -n 1 "$wpn_name_file" | cut -d "|" -f 1)
        echo "$random_name"
    else
        echo "Weapon name file doesn't exist."
        exit 1
    fi
}

function get_wpn_description() {
    local wpn_name_file="../enemies/names.txt"
    if [ -f "$enemy_name_file" ]; then
        local description=$(grep "^$1" "$wpn_name_file" | cut -d "|" -f 2- | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
        echo "$description"
    else
        echo "Weapon name file doesn't exist."
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