#!/bin/bash

source $SRC_PATH/create_char_menus.sh
source $SRC_PATH/weapons.sh

function create_character() {
    echo_welcome
    echo_race_menu
    local accepted=0
    until [ $accepted -eq 1 ]; do
        read -rsn 1 race_num
        case "$race_num" in
            1)
                RACE="HUMAN"
                echo_race_menu
            ;;
            2)  
                RACE="MLOK"
                echo_race_menu
            ;;
            3)
                RACE="CAKE"
                echo_race_menu
            ;;
            4)
                RACE="FISH"
                echo_race_menu
            ;;
            5)
                if [ "$RACE" != "" ]; then
                    accepted=1
                fi
            ;;
            *);;
        esac
    done

    echo_class_menu
    accepted=0
    until [ $accepted -eq 1 ]; do
        read -rsn 1 class_num
        case "$class_num" in
            1)
                CLASS="FIGHTER"
                echo_class_menu
            ;;
            2)  
                CLASS="CHEMIST"
                echo_class_menu
            ;;
            3)
                CLASS="GUARD"
                echo_class_menu
            ;;
            4)
                CLASS="PSYCHO"
                echo_class_menu
            ;;
            5)
                if [ "$CLASS" != "" ]; then
                    accepted=1
                fi
            ;;
            *);;
        esac
    done
}

function choose_wpn() {
    init_starting_wpns
    echo_wpn_menu
    local accepted=0
    until [ $accepted -eq 1 ]; do
        read -rsn 1 strt_wpn_num
        case "$strt_wpn_num" in
            1)
                STRT_WPN=1
                echo_wpn_menu
            ;;
            2)  
                STRT_WPN=2
                echo_wpn_menu
            ;;
            3)
                STRT_WPN=3
                echo_wpn_menu
            ;;
            5)
                if [ "$STRT_WPN" != "0" ]; then
                    accepted=1
                fi
            ;;
            *);;
        esac
    done

    case "$STRT_WPN" in
        1)
            weapon.init "$(display_wpn1.name)" "$(display_wpn1.stm_per_use)" "$(display_wpn1.quantity)"
        ;;
        2)
            weapon.init "$(display_wpn2.name)" "$(display_wpn2.stm_per_use)" "$(display_wpn2.quantity)"
        ;;
        3) 
            weapon.init "$(display_wpn3.name)" "$(display_wpn3.stm_per_use)" "$(display_wpn3.quantity)"
        ;;
    esac
}