#!/bin/bash

. system.h
. character.h
. item.h

source menu.sh

BRED='\033[1;31m'
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

meassage="What will you do?"
echo_menu
until [ "$(player.current_health)" -lt "0" ] || [ "$(player.current_health)" == "0" ]; do
    echo -e $meassage
    read -p "Your action: " action
    if [ "$action" == "1" ]; then
        echo_menu
        echo 1
    elif [ "$action" == "2" ]; then
        echo_menu
        echo 2
    elif [ "$action" == "3" ]; then
        echo_menu
        echo 3
    elif [ "$action" == "4" ]; then
        echo_menu
        echo 4
    elif [ "$action" == "5" ]; then
        echo_menu
        echo 5
    elif [ "$action" == "6" ]; then
        echo_info_menu
        echo 6
    else
        echo_menu
        meassage=${BRED}"Incorrect action"${NONE}
    fi
done
