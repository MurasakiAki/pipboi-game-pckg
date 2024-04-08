#!/bin/bash

source create_char_menus.sh

function init_starting_wpns() {
    display_wpn1.init "$(get_random_wpn_name)" "$(get_random_number 4 $(player.max_stamina))" "$(get_random_number 7 12)"
    display_wpn2.init "$(get_random_wpn_name)" "$(get_random_number 8 $(player.max_stamina))" "$(get_random_number 10 13)"
    display_wpn3.init "$(get_random_wpn_name)" "$(get_random_number 5 $(player.max_stamina))" "$(get_random_number 5 15)"
    if [ "$CLASS" == "FIGHTER" ]; then
        local d_wpn1_dmg=$(display_wpn1.quantity)
        local d_wpn2_dmg=$(display_wpn2.quantity)
        local d_wpn2_dmg=$(display_wpn3.quantity)

        display_wpn1.quantity = $(($d_wpn1_dmg + 2))
        display_wpn2.quantity = $(($d_wpn2_dmg + 2))
        display_wpn3.quantity = $(($d_wpn3_dmg + 2))
    elif [ "$CLASS" == "PSYCHO" ]; then
        local d_wpn1_spu=$(display_wpn1.stm_per_use)
        local d_wpn2_spu=$(display_wpn2.stm_per_use)
        local d_wpn2_spu=$(display_wpn3.stm_per_use)

        display_wpn1.stm_per_use = $(($d_wpn1_spu - 2))
        display_wpn2.stm_per_use = $(($d_wpn2_spu - 2))
        display_wpn3.stm_per_use = $(($d_wpn3_spu - 2))
    fi
}

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
            4)
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