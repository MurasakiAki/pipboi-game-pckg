#!/bin/bash

. system.h
. character.h
. item.h

source maths.sh
source menus.sh
source enemy_logic.sh

RED='\033[0;31m'
BRED='\033[1;31m'
ORANGE='\033[1;33m'
GREEN='\033[0;32m'
BGREEN='\033[1;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BBLUE='\033[1;34m'
GRAY='\033[1;30m'
CYAN='\033[0;36m'
NONE='\033[0m'

LEVEL=9
TURN=1
WHOSE_TURN=""

# item weapon is special item
item weapon
weapon.init "Hacksaw" 2 10 #quantity = damage

item syringe
syringe.init "Syringe" 5 5

item smoke_bomb
smoke_bomb.init "Smoke Bomb" 6 2

item molotov
molotov.init "Molotov" 4 6

character player
player.init "aki" 100 13
player.STR = 2
player.PER = 6
player.DEX = 0
player.AGI = 15
player.is_defending = 0
player.is_on_fire = 0
player.fire_time = 0
player.is_smoked = 0
player.smoke_time = 0
player.caps = 0

item enemy_weapon
enemy_weapon.init "Attack" 5 5

character enemy
enemy.init "$(get_random_name)" 20 10
enemy.STR = 2
enemy.PER = 0
enemy.DEX = 3
enemy.AGI = 10
enemy.is_defending = 0
enemy.is_on_fire = 0
enemy.fire_time = 0
enemy.is_smoked = 0
enemy.smoke_time = 0
enemy.caps = 10

function who_is_faster() {
    player_agi=$(player.AGI)
    enemy_agi=$(enemy.AGI)

    if [ "$player_agi" -ge "$enemy_agi" ]; then
        echo "player"
    else
        echo "enemy"
    fi
}

function player_turn() {
    echo_players_turn
    player.is_defending = "0"
    player.current_stamina = $(player.max_stamina)
    message="What will you do?                  7) ${YELLOW}End Turn${NONE}"
    echo_menu
    action=""
    until [ "$action" == "7" ]; do
        echo -e "$message"
        message="What will you do?                  7) ${YELLOW}End Turn${NONE}"
        read -p "Your action: " action

        case "$action" in
            1)
                if [ "$(weapon.stm_per_use)" -le "$(player.current_stamina)" ]; then
                    weapon_stm=$(weapon.stm_per_use)
                    player_stm=$(player.current_stamina)
                    player.current_stamina = $((player_stm - weapon_stm))
                    damage="$(weapon.quantity)"
                    enemy_health=$(enemy.current_health)
                    final_damage=$damage
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
                    fi

                    enemy_hp=$((enemy_health - final_damage))
                    if [ "$enemy_hp" -lt "0" ]; then
                        enemy_hp="0"
                    fi
                    enemy.current_health = $enemy_hp
                    echo_menu
                else
                    message="${GREEN}Not enough stamina!${NONE}                7) ${YELLOW}End Turn${NONE}"
                    echo_menu 
                fi 
                ;;
            2)  
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

                echo_menu 
                ;;
            3)  
                player_max_stm=$(player.max_stamina)
                defend_cost=$((player_max_stm / 2))
                if [ "$defend_cost" -le "$(player.current_stamina)" ]; then
                    player.is_defending = "1"
                    player_stm=$(player.current_stamina)
                    player.current_stamina = $((player_stm - defend_cost))
                    message="player is defending"
                    echo_menu
                else
                    message="${GREEN}Not enough stamina!${NONE}                7) ${YELLOW}End Turn${NONE}"
                    echo_menu 
                fi
                ;;
            4) 
                a=$(get_random_number)
                b=$(get_random_number)
                mult=$((a * (b + LEVEL / 2)))
                if [ "$mult" -le "$(player.AGI)" ]; then
                    message="player ran away $mult $a $b"
                else
                    message="player did not ran away $mult $a $b"
                fi
                echo_menu
                ;;
            5) echo_use_menu 
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
                ;;
            6) echo_info_menu
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
                        8) exit 0 
                            ;;
                        *) echo_info_menu
                            message="${BRED}Invalid choice${NONE}                     7) ${YELLOW}End Turn${NONE}"
                            ;;
                    esac
                done
                ;;
            7) TURN=$((TURN + 1))
                ;;
            *) echo_menu
                message="${BRED}Invalid action${NONE}                     7) ${YELLOW}End Turn${NONE}" 
                ;;
        esac
    done
}

function enemy_turn() {
    echo_enemy_turn
    enemy.is_defending = "0"
    if [ "$(enemy.is_on_fire)" -eq "1" ] && [ "$(enemy.fire_time)" -gt "0" ]; then
        damage=$(calculate_percentage "$(weapon.quantity)" 10)
        enemy_chealth=$(enemy.current_health)
        enemy.current_health = $((enemy_chealth - damage))
        f_time=$(enemy.fire_time)
        enemy.fire_time = $((f_time - 1))
        if [ "$(enemy.fire_time)" -eq "0" ]; then
            enemy.is_on_fire = 0
        fi
    fi
    if [ "$(enemy.is_smoked)" -eq "1" ] && [ "$(enemy.smoke_time)" -gt "0" ]; then
        enemy_max_stm=$(enemy.max_stamina)
        stm_debuff=$((enemy_max_stm / 2))
        enemy.current_stamina = $stm_debuff
        s_time=$(enemy.smoke_time)
        enemy.smoke_time = $((s_time - 1))
        if [ "$(enemy.smoke_time)" -eq "0" ]; then
            enemy.is_smoked = 0
        fi
    else
        enemy.current_stamina = $(enemy.max_stamina)
    fi

    until [ "$(enemy.current_stamina)" -le "0" ]; do
        echo_menu
        echo -e "${RED}ENEMY TURN${NONE}"
        echo "enemy will ""$(decide_action)"
        execute_action
        sleep 2
        if [ "$(enemy.is_defending)" -eq "1" ]; then
            break
        fi
    done
}

function start_game() {
    until [ "$(player.current_health)" -le 0 ]; do
        whose_turn=$(who_is_faster)
        if [ "$whose_turn" == "enemy" ]; then
            enemy_turn
            if [ "$(enemy.current_health)" -le 0 ]; then
                echo_enemy_defeated
                change_enemy
            else
                player_turn
            fi
        else
            player_turn
            if [ "$(enemy.current_health)" -le 0 ]; then
                echo_enemy_defeated
                change_enemy
            else
                enemy_turn
            fi
        fi
    done
}

start_game
