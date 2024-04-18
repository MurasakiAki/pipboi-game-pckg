#!/bin/bash

source $SRC_PATH/maths.sh

function init_enemy() {
    enemy.STR = $(( $(get_random_number 1 4) + LEVEL ))
    enemy.PER = $(( $(get_random_number 1 4) + LEVEL ))
    enemy.DEX = $(( $(get_random_number 1 4) + LEVEL ))
    enemy.AGI = $(( $(get_random_number 1 4) + LEVEL ))
    local enemy_str=$(enemy.STR)
    local enemy_dex=$(enemy.DEX)

    local enemy_health=$(( enemy_str * $(get_random_number 2 5) ))
    local enemy_stamina=$(( enemy_dex * $(get_random_number 2 5) ))

    local enemy_name=$(get_random_name)
    enemy.init "$enemy_name" $enemy_health $enemy_stamina

    local weapon_stamina_cost=$(( enemy_dex > 0 ? enemy_stamina / enemy_dex : enemy_stamina ))
    
    if [ "$weapon_stamina_cost" -lt "0" ]; then
        weapon_stamina_cost=$(( -1 * weapon_stamina_cost ))
    elif [ "$weapon_stamina_cost" -eq "0" ]; then
        weapon_stamina_cost=$enemy_dex
        enemy_stamina=$enemy_dex
    fi

    local weapon_damage=$(( $(get_random_number 1 10) * LEVEL - enemy_dex))
    if [ "$weapon_damage" -le "0" ]; then
        weapon_damage=1
    fi
    enemy_weapon.init "Attack" $weapon_stamina_cost $weapon_damage

    enemy.is_defending = 0
    enemy.is_on_fire = 0
    enemy.fire_time = 0
    enemy.is_smoked = 0
    enemy.smoke_time = 0
    
    if [ "$(enemy.current_health)" -lt "0" ]; then
        enemy_health=$(( -1 * enemy.current_health ))
        enemy.max_health = $enemy_health
        enemy.current_health = $enemy_health
    fi

    if [ "$(enemy.current_stamina)" -lt "0" ]; then
        enemy_stamina=$(( -1 * enemy.current_stamina ))
        enemy.max_stamina = $enemy_stamina
        enemy.current_stamina = $enemy_stamina
    fi
}

function decide_action() {
    enemy_chp=$(enemy.current_health)
    enemy_mhp=$(enemy.max_health)
    enemy_max_stm=$(enemy.max_stamina)

    if [ $enemy_chp -le "$(calculate_percentage "$enemy_mhp" 10)" ] && [ "$LEVEL" -ge "20" ]; then
        echo "heal"
        return
    fi

    if [ "$(enemy.is_defending)" -eq "1" ]; then
        echo "pass"
        return
    fi

    if [ $enemy_chp -le "$(calculate_percentage "$enemy_mhp" 10)" ]; then
        echo "defend"
        return
    fi

    if [ "$(enemy.current_stamina)" -ge "$(enemy_weapon.stm_per_use)" ]; then
        echo "attack"
        return
    fi

    echo "pass"
}

function attack() {
    eweapon_stm=$(enemy_weapon.stm_per_use)
    enemy_cstm=$(enemy.current_stamina)
    enemy.current_stamina = $((enemy_cstm - eweapon_stm))
    player_hp=$(player.current_health)
    final_e_damage=$(calc_damage "$(enemy_weapon.quantity)" "$(enemy.PER)" "$(enemy.STR)")
    if [ "$(player.is_defending)" -eq "1" ]; then
        player_str=$(player.STR)
        player_dmg=$(weapon.quantity)
        player_w_bonus=$(calculate_percentage "$player_dmg" 25)
        weapon.quantity = $player_dmg
        p_defend_bonus=$((player_str + player_w_bonus))
        final_e_damage=$((final_e_damage - p_defend_bonus))
        if [ "$CLASS" == "GUARD" ]; then
            final_e_damage=$((final_e_damage - 2))
        fi

        if [ "$final_e_damage" -lt "0" ]; then
            final_e_damage=0
        fi
    fi
    player_hp=$((player_hp - final_e_damage))
    if [ "$player_hp" -lt "0" ]; then
        player_hp="0"
    fi
    player.current_health = $player_hp
    ACTION_MSG="Enemy hit you for $final_e_damage"
    echo_menu
    sleep 2
}

function defend() {
    enemy_cur_stm=$(enemy.current_stamina)
    enemy_max_stm=$(enemy.max_stamina)
    if [ "$enemy_cur_stm" -ge "$((enemy_max_stm / 2))" ]; then
        enemy.current_stamina = $((enemy_cur_stm - (enemy_max_stm / 2)))
        enemy.is_defending = 1
    fi
}