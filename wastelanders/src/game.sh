#!/bin/bash

. system.h
. character.h
. item.h

source menus.sh

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

LEVEL=1
TURN=1

# item weapon is special item
item weapon
weapon.init "Hacksaw" 6 15  #quantity = damage

item syringe
syringe.init "Syringe" 5 5

item smoke_bomb
smoke_bomb.init "Smoke Bomb" 6 2

item molotov
molotov.init "Molotov" 4 6

character player
player.init "aki" 100 10 $(weapon.quantity)

character enemy
enemy.init "zombie" 20 10 5
until [ "$(player.current_health)" -le 0 ]; do
    message="What will you do?                  7) ${YELLOW}End Turn${NONE}"
    echo_menu
    echo "$TURN"
    action=""
    until [ "$action" == "7" ]; do
        echo -e "$message"
        message="What will you do?                  7) ${YELLOW}End Turn${NONE}"
        read -p "Your action: " action

        case "$action" in
            1)
                if [ $(weapon.stm_per_use) -le $(player.current_stamina) ]; then
                    player_stm=$(player.current_stamina)
                    weapon_stm=$(weapon.stm_per_use)
                    player.current_stamina = $((player_stm - weapon_stm))
                    damage=$(player.damage)
                    enemy_health=$(enemy.current_health)
                    enemy.current_health = $((enemy_health - damage))
                    echo_menu 
                else
                    message="${GREEN}Not enough stamina!${NONE}"
                    echo_menu 
                fi 
                ;;
            2) echo_menu 
                ;;
            3) echo_menu 
                ;;
            4) echo_menu 
                ;;
            5) echo_menu 
                ;;
            6) echo_info_menu
                message="What do you want to know?"
                while true; do
                    echo -e "$message"
                    message="What do you want to know?"
                    read -p "Your choice: " choice
                    case "$choice" in
                        1) echo_info_menu "ENEMY" 
                            ;;
                        2) lines=("SYR" "$(syringe.name)" "By using this item, you'll" "inject yourself with syringe." "" "Will heal you for 25% of your" "max health, uses 5 stamina.")
                            echo_info_menu "${lines[@]}" 
                            ;;
                        3) lines=("SMB" "$(smoke_bomb.name)" "By using this item, you'll" "thow a smoke bomb" "at your enemy." "" "Decreases stamina of your" "enemy for 3 turns," "uses 6 stamina.")
                            echo_info_menu "${lines[@]}" 
                            ;;
                        4) lines=("MLT" "$(molotov.name)" "By using this item, you'll" "thow a molotov coctail at your" "enemy." "" "Hurts enemy for 10% of your" "damage for 3 turns at the" "begining of each turn," "uses 4 stamina." )
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
                            message="${BRED}Invalid choice${NONE}"
                            ;;
                    esac
                done 
                ;;
            7) TURN=$((TURN + 1))
                ;;
            *) echo_menu
                message="${BRED}Invalid action${NONE}" 
                ;;
        esac
    done
done