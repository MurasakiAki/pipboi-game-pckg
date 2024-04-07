#!/bin/bash

source maths.sh

function get_random_name() {
    enemy_name_file="../enemies/names.txt"
    if [ -f "$enemy_name_file" ]; then
        random_name=$(shuf -n 1 "$enemy_name_file" | cut -d "|" -f 1)
        echo "$random_name"
    else
        echo "Enemy name file doesn't exist."
        exit 1
    fi
}

function init_enemy() {
    enemy.STR = $(($(get_random_number) * LEVEL))
    enemy.PER = $(($(get_random_number) * LEVEL))
    enemy.DEX = $(($(get_random_number) * LEVEL))
    enemy.AGI = $(($(get_random_number) * LEVEL))
    enemy_str=$(check_stat "$(enemy.STR)")
    enemy.STR = $enemy_str
    enemy_dex=$(check_stat "$(enemy.DEX)")
    enemy.DEX = $enemy_dex
    enemy_agi=$(check_stat "$(enemy.AGI)")
    enemy.AGI = $enemy_agi
    enemy_per=$(check_stat "$(enemy.PER)")
    enemy.PER = $enemy_per
    hp_beg=$(($(get_random_number 1 5) * enemy_str - LEVEL))
    hp_end=$(($(get_random_number 6 10) * enemy_str + LEVEL))
    stm_beg=$(($(get_random_number 1 5) * enemy_dex + LEVEL))
    stm_end=$(($(get_random_number 6 10) * enemy_agi - LEVEL))
    enemy.init "$(get_random_name)" "$(($(get_random_number hp_beg hp_end) - enemy_dex))" "$(($(get_random_number stm_beg stm_end) - enemy_str))"
    enemy_max_stm=$(enemy.max_stamina)
    w_stm_beg=$((enemy_max_stm - LEVEL))
    enemy_weapon.init "Attack" "$(($(get_random_number w_stm_beg enemy_max_stm) - enemy_dex))" "$(($(get_random_number) * LEVEL))"
    enemy.is_defending = 0
    enemy.is_on_fire = 0
    enemy.fire_time = 0
    enemy.is_smoked = 0
    enemy.smoke_time = 0
    if [ "$(enemy.current_health)" -lt "0" ]; then
        enemy_chp=$(enemy.current_health)
        enemy_chp=$((enemy_chp * -1))
        enemy.max_health = $enemy_chp
        enemy.current_health = $enemy_chp
    fi

    if [ "$(enemy.current_stamina)" -lt "0" ]; then
        enemy_cstm=$(enemy.current_stamina)
        enemy_cstm=$((enemy_cstm * -1))
        enemy.max_stamina = $enemy_cstm
        enemy.current_stamina = $enemy_cstm
    fi
}

function get_description() {
    enemy_name_file="../enemies/names.txt"
    if [ -f "$enemy_name_file" ]; then
        description=$(grep "^$1" "$enemy_name_file" | cut -d "|" -f 2- | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
        echo "$description"
    else
        echo "Enemy name file doesn't exist."
        exit 1
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

    if [ $enemy_chp -le "$(calculate_percentage "$enemy_mhp" 10)" ]; then
        echo "defend"
        return
    fi

    if [ "$(enemy.current_stamina)" -ge "$(enemy_weapon.stm_per_use)" ]; then
        echo "attack"
        return
    fi

    if [ "$(enemy.is_defending)" -eq "1" ]; then
        echo "pass"
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