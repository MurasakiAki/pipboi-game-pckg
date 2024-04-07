#!/bin/bash

. character.h
. item.h

source checks.sh
source maths.sh
source menus.sh
source player_logic.sh
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

LEVEL=1
TURN=1
WHOSE_TURN=""
SCORE=0
RAN_AWAY=0
DEFEATED_ENEMIES=0
ACTION_MSG="Enemy is waiting."

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

item enemy_weapon
character enemy

init_enemy

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
    ACTION_MSG="Enemy is waiting."
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
            1)  do_attack
                echo_menu
                ;;
            2)  do_heal
                echo_menu 
                ;;
            3)  do_defend
                echo_menu
                ;;
            4)  do_run
                echo_menu
                ;;
            5) do_use
                ;;
            6) do_info_menu
                ;;
            7) do_end_turn
                ;;
            *) echo_menu
                message="${BRED}Invalid action${NONE}                     7) ${YELLOW}End Turn${NONE}" 
                ;;
        esac
    done
}

function enemy_turn() {
    ACTION_MSG="Enemy turn."
    echo_menu
    enemy_chp=$(enemy.current_health)
    if [ "$enemy_chp" -gt "0" ]; then
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
            enemy.current_stamina = "$stm_debuff"
            s_time=$(enemy.smoke_time)
            enemy.smoke_time = $((s_time - 1))
            if [ "$(enemy.smoke_time)" -eq "0" ]; then
                enemy.is_smoked = 0
            fi
        else
            enemy.current_stamina = $(enemy.max_stamina)
        fi

        while [ "$(enemy.current_stamina)" -gt "0" ]; do
            action=$(decide_action)
            ACTION_MSG="Enemy is deciding."
            echo_menu
            sleep 2
            ACTION_MSG="Enemy is $action""ing!"
            echo_menu
            sleep 2
            if [ "$action" == "pass" ]; then
                break
            fi

            if [ "$action" == "attack" ]; then
                if [ "$(enemy.current_stamina)" -ge "$(enemy_weapon.stm_per_use)" ]; then
                    attack
                    
                fi
            elif [ "$action" == "defend" ]; then
                if [ "$(enemy.is_defending)" -eq "0" ]; then
                    defend
                fi
            fi
            
        done
    fi
}

function start_game() {
    until [ "$(player.current_health)" -le 0 ]; do
        whose_turn=$(who_is_faster)
        if [ "$whose_turn" == "enemy" ]; then
            enemy_turn
            if [ "$(enemy.current_health)" -le 0 ]; then
                echo_enemy_defeated
                DEFEATED_ENEMIES=$((DEFEATED_ENEMIES + 1))
                LEVEL=$((DEFEATED_ENEMIES / 5 + 1))
                LEVEL=$(check_lvl_stat "$LEVEL")
                init_enemy
            else
                player_turn
            fi
        else
            player_turn
            if [ "$(enemy.current_health)" -le 0 ]; then
                echo_enemy_defeated
                DEFEATED_ENEMIES=$((DEFEATED_ENEMIES + 1))
                LEVEL=$((DEFEATED_ENEMIES / 5 + 1))
                LEVEL=$(check_lvl_stat "$LEVEL")
                init_enemy
            else
                enemy_turn
            fi
        fi
    done
    echo_eval_menu
}

start_game