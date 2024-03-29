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

# item weapon is special item
item weapon
weapon.init "Hacksaw" 6 15 #description = stm per use, quantity = damage

item syringe
syringe.init "Syringe" "Will heal you for 25% of your max health, uses 5 stamina." 5

item smoke_bomb
smoke_bomb.init "Smoke Bomb" "Decreases stamina of your enemy for 3 turns, uses 6 stamina." 2

item molotov
molotov.init "Molotov" "Hurts enemy for 10% of your damage for 3 turns at the begining of each turn, uses 4 stamina." 6

character player
player.init "aki" 100 10 $(weapon.quantity)

character enemy
enemy.init "zombie" 20 10 5

message="What will you do?"
echo_menu
until [ "$(player.current_health)" -le 0 ]; do
    echo -e "$message"
    message="What will you do?"
    read -p "Your action: " action

    case "$action" in
        1) echo_menu
            echo 1 ;;
        2) echo_menu
            echo 2 ;;
        3) echo_menu
            echo 3 ;;
        4) echo_menu
            echo 4 ;;
        5) echo_menu
            echo 5 ;;
        6) echo_info_menu
            message="What do you want to know?"
            while true; do
                echo -e "$message"
                message="What do you want to know?"
                read -p "Your choice: " choice
                case "$choice" in
                    1) echo_info_menu ${RED}ENEMY${NONE} ;;
                    2) echo_info_menu
                        echo "###############"
                        echo -e ${BRED}SYR${NONE}
                        echo $(syringe.name)
                        echo "By using this item, you'll inject yourself with syringe"
                        echo $(syringe.description)
                        echo "###############" ;;
                    3) echo_info_menu
                        echo "###############"
                        echo -e ${GRAY}SMB${NONE}
                        echo $(smoke_bomb.name)
                        echo "By using this item, you'll thow a smoke bomb at your enemy"
                        echo $(smoke_bomb.description)
                        echo "###############" ;;
                    4) echo_info_menu
                        echo "###############"
                        echo -e ${ORANGE}MLT${NONE}
                        echo $(molotov.name)
                        echo "By using this item, you'll thow a molotov coctail at your enemy"
                        echo $(molotov.description)
                        echo "###############" ;;
                    5) echo_info_menu
                        echo "###############"
                        echo -e ${BLUE}DEFEND${NONE}
                        echo "The ability to defend yourself is based on your STR."
                        echo "The damage taken in next turn will be decreased by each point of STR you have + 25% of your weapons damage."
                        echo "This ability uses 50% of your max stamina."
                        echo "###############" ;;
                    6) echo_info_menu
                        echo "###############"
                        echo -e ${YELLOW}RUN${NONE}
                        echo "Running away is a valid tactic."
                        echo "You will try to run away from the fight, your chance of escaping is based on your AGI"
                        echo "If you succesfully escape, you will end the game. If you won't, there will be consequences."
                        echo "###############" ;;
                    7) echo_menu
                        break ;;
                    8) exit 0 ;;
                   *) echo_info_menu
                        message="${BRED}Invalid choice${NONE}" ;;
                esac
            done ;;
        *) echo_menu
            message="${BRED}Invalid action${NONE}" ;;
    esac
done