#!/bin/bash

source create_char_menus.sh

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