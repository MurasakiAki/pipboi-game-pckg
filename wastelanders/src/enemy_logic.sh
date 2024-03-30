#!/bin/bash

#how many percentage from number
calculate_percentage() {
    local number="$1"
    local percentage="$2"
    echo "$(( (number * percentage) / 100 ))"
}

function decide_action() {
    enemy_chp=$(enemy.current_health)
    enemy_mhp=$(enemy.max_health)
    if [ $enemy_chp -ge "$(calculate_percantage "$enemy_mhp" 10)"]; then
        
    fi
}

