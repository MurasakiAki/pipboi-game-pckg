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
        if [ "$(enemy.current_stamina)" -ge "$(enemy_weapon.stm_per_use)" ]; then
            attack
        fi
    elif [ "$action" == "defend" ]; then
        if [ "$(enemy.is_defending)" -eq "0" ]; then
            defend
        fi
    fi
}

function attack() {
    eweapon_stm=$(enemy_weapon.stm_per_use)
    enemy_cstm=$(enemy.current_stamina)
    enemy.current_stamina = $((enemy_cstm - eweapon_stm))
    damage=$(enemy_weapon.quantity)
    player_hp=$(player.current_health)
    final_e_damage=$damage
    if [ "$(player.is_defending)" -eq "1" ]; then
        player_str=$(player.STR)
        player_dmg=$(weapon.quantity)
        player_w_bonus=$(calculate_percentage "$player_dmg" 25)
        weapon.quantity = $player_dmg
        p_defend_bonus=$((player_str + player_w_bonus))
        final_e_damage=$((final_e_damage - p_defend_bonus))
    fi
    player_hp=$((player_hp - final_e_damage))
    if [ "$player_hp" -lt "0" ]; then
        player_hp="0"
    fi
    player.current_health = $player_hp
}

function defend() {
    enemy_cur_stm=$(enemy.current_stamina)
    enemy_max_stm=$(enemy.max_stamina)
    if [ "$enemy_cur_stm" -ge "$((enemy_max_stm / 2))" ]; then
        enemy.current_stamina = $((enemy_cur_stm - (enemy_max_stm / 2)))
        enemy.is_defending = 1
    fi
}