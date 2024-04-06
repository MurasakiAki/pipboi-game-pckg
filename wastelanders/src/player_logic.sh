#!/bin/bash

source maths.sh

function calc_damage() {
    local weapon_dmg=$(weapon.quantity)
    local player_per=$(player.PER)
    local player_str=$(player.STR)
    local base_dmg=$((weapon_dmg + player_str))
    local random_modifier=$(get_random_number -$((player_per / 3)) $((player_per / 3)))
    local critical_chance=$(get_random_number 1 100)
    
    if [ $critical_chance -le $player_per ]; then
        base_dmg=$((base_dmg * 2))
    fi
    
    local final_dmg=$((base_dmg + random_modifier))
    final_dmg=$((final_dmg > 0 ? final_dmg : 0))
    
    echo $final_dmg
}

function do_attack() {
    if [ "$(weapon.stm_per_use)" -le "$(player.current_stamina)" ]; then
        weapon_stm=$(weapon.stm_per_use)
        player_stm=$(player.current_stamina)
        player.current_stamina = $((player_stm - weapon_stm))
        enemy_health=$(enemy.current_health)
        final_damage=$(calc_damage)
        echo $final_damage
        if [ "$(enemy.is_defending)" -eq "1" ]; then
            enemy_str=$(enemy.STR)
            enemy_dmg=$(enemy_weapon.quantity)
            enemy_w_bonus=$(calculate_percentage "$enemy_dmg" 25)
            enemy_weapon.quantity = $enemy_dmg
            e_defend_bonus=$((enemy_str + enemy_w_bonus))
            final_damage=$((final_damage - e_defend_bonus))
            if [ "$final_damage" -lt "0" ]; then
                final_damage="0"
            fi
        
        enemy_hp=$((enemy_health - final_damage))
        if [ "$enemy_hp" -lt "0" ]; then
            enemy_hp="0"
        fi
        enemy.current_health = $enemy_hp
    else
        message="${GREEN}Not enough stamina!${NONE}                7) ${YELLOW}End Turn${NONE}"
    fi
}

function do_heal() {
    player_stm=$(player.current_stamina)
    syr_qnt=$(syringe.quantity)
    heal_cost=4
    if [ "$player_stm" -ge "$heal_cost" ]; then
        if [ "$syr_qnt" -gt "0" ]; then
            player_max_hp=$(player.max_health)
            health_to_add=$(calculate_percentage "$player_max_hp" 25)
            player_chealth=$(player.current_health)
            final_health=$((player_chealth + health_to_add))
            if [ "$player_chealth" -eq "$player_max_hp" ]; then
                player.current_health = $(player.max_health)
                message="${BRED}You have full health${NONE}               7) ${YELLOW}End Turn${NONE}"
            elif [ "$final_health" -gt "$player_max_hp" ]; then
                player.current_stamina = $((player_stm - heal_cost))
                syringe.quantity = $((syr_qnt - 1))
                player.current_health = $(player.max_health)
                message="${BRED}You feel relieved${NONE}                 7) ${YELLOW}End Turn${NONE}"
            else
                player.current_stamina = $((player_stm - heal_cost))
                syringe.quantity = $((syr_qnt - 1))
                player.current_health = "$final_health"
                message="${BRED}You feel relieved${NONE}                 7) ${YELLOW}End Turn${NONE}"
            fi
        else 
            message="${BRED}Not enough syringes${NONE}                7) ${YELLOW}End Turn${NONE}"
        fi
    else
        message="${GREEN}Not enough stamina!${NONE}                7) ${YELLOW}End Turn${NONE}"
    fi
}

function do_defend() {
    player_max_stm=$(player.max_stamina)
    defend_cost=$((player_max_stm / 2))
    if [ "$defend_cost" -le "$(player.current_stamina)" ]; then
        player.is_defending = "1"
        player_stm=$(player.current_stamina)
        player.current_stamina = $((player_stm - defend_cost))
        message="player is defending"
    else
        message="${GREEN}Not enough stamina!${NONE}                7) ${YELLOW}End Turn${NONE}"
    fi
}

function do_run() {
    a=$(get_random_number)
    b=$(get_random_number)
    mult=$((a * (b + LEVEL / 2)))
    if [ "$mult" -le "$(player.AGI)" ]; then
        message="player ran away $mult $a $b"
        RAN_AWAY=1
    else
        message="player did not ran away $mult $a $b"
    fi
}

function do_use() {
    echo_use_menu 
    message="What do you want to use?"
    while true; do
        echo -e "$message"
        message="What do you want to use?"
        read -p "What will you use: " item_to_use
        case "$item_to_use" in
            1) #mlt
                player_stm=$(player.current_stamina)
                mlt_qnt=$(molotov.quantity)
                mlt_cost=4
                if [ "$player_stm" -ge "$mlt_cost" ]; then
                    if [ "$mlt_qnt" -gt "0" ]; then
                        if [ "$(enemy.is_on_fire)" -eq "0" ]; then
                            molotov.quantity = $((mlt_qnt - 1))
                            player.current_stamina = $((player_stm - mlt_cost))
                            enemy.is_on_fire = 1
                            enemy.fire_time = 3
                            echo_use_menu
                        else
                            message="${ORANGE}Enemy is already on fire${NONE}"
                            echo_use_menu
                        fi
                    else
                        message="${ORANGE}Not enough molotovs${NONE}"
                        echo_use_menu
                    fi
                else
                    message="${GREEN}Not enough stamina!${NONE}"
                    echo_use_menu
                fi
                ;;
            2) #smb
                player_stm=$(player.current_stamina)
                smb_qnt=$(smoke_bomb.quantity)
                smb_cost=6
                if [ "$player_stm" -ge "$smb_cost" ]; then
                    if [ "$smb_qnt" -gt "0" ]; then
                        if [ "$(enemy.is_smoked)" -eq "0" ]; then
                            smoke_bomb.quantity = $((smb_qnt - 1))
                            player.current_stamina = $((player_stm - smb_cost))
                            enemy.is_smoked = 1
                            enemy.smoke_time = 3
                            echo_use_menu
                        else
                            message="${ORANGE}Enemy is already smoked${NONE}"
                            echo_use_menu
                        fi
                    else
                        message="${ORANGE}Not enough smoke bombs${NONE}"
                        echo_use_menu
                    fi
                else
                    message="${GREEN}Not enough stamina!${NONE}"
                    echo_use_menu
                fi
                ;;
            3) 
                echo_menu
                break
                ;;
            *) message="${BRED}Invalid input${NONE}" ;;
        esac
    done
}

function do_info_menu() {
    echo_info_menu
    message="What do you want to know?"
    while true; do
        echo -e "$message"
        message="What do you want to know?"
        read -p "Your choice: " choice
        case "$choice" in
            1) lines=("$(enemy.name)" "" "$(get_description "$(enemy.name)")")
                echo_info_menu "${lines[@]}"
                ;;
            2) lines=("SYR" "$(syringe.name)" "By using this item, you'll" "inject yourself with syringe." "" "Will heal you for 25% of your" "max health, uses 5 stamina.")
                echo_info_menu "${lines[@]}" 
                ;;
            3) lines=("SMB" "$(smoke_bomb.name)" "By using this item, you'll" "throw a smoke bomb" "at your enemy." "" "Decreases stamina of your" "enemy for 3 turns," "uses 6 stamina.")
                echo_info_menu "${lines[@]}" 
                ;;
            4) lines=("MLT" "$(molotov.name)" "By using this item, you'll" "throw a molotov coctail" "at your enemy." "" "Hurts enemy for 10% of your" "damage for 3 turns at the" "beginning of each turn," "uses 4 stamina." )
                echo_info_menu "${lines[@]}" 
                ;;
            5) lines=("DEFEND" "The ability to defend yourself" "is based on your STR." "" "The damage taken in next turn" "will be decreased by each" "point of STR you have + 25% of" "your weapons damage." "" "This ability uses 50% of" "your max stamina.")
                echo_info_menu "${lines[@]}" 
                ;;
            6) lines=("RUN" "Running away is a valid tactic" "" "You will try to run away" "from the fight, your chance" "of escaping is based on" "your AGI." "If you succesfully escape," "you will end the game." "If you won't," "there will be consequences.")
                echo_info_menu "${lines[@]}" 
                ;;
            7) echo_menu 
                break
                ;;
            8) echo_eval_menu
                exit 0
                ;;
            *) echo_info_menu
                message="${BRED}Invalid choice${NONE}                     7) ${YELLOW}End Turn${NONE}"
                ;;
        esac
    done
}

function do_end_turn() {
    TURN=$((TURN + 1))
}