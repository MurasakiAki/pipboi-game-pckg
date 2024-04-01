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
    if [ $enemy_chp -le "$(calculate_percentage "$enemy_mhp" 10)" ]; then
        if [ "$LEVEL" -ge "20" ]; then
            echo "heal"
        fi
        echo "defend"
    else 
        echo "attack"
    fi
}

function execute_action() {
    action="$(decide_action)"
    if [ "$action" == "attack" ]; then
        player_chp=$(player.current_health)
        enemy_cstm=$(enemy.current_stamina)
        eweapon_stm=$(enemy_weapon.stm_per_use)
        damage=$(enemy.damage)
        enemy.current_stamina = $((enemy_cstm - eweapon_stm))
        player.current_health = $((player_chp - damage))
    fi
}