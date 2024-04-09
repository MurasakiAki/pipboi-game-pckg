#!/bin/bash

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

function echo_welcome() {
    clear
    echo -e "/============================================\\"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|          ${BGREEN}Welcome to Wastelanders!${NONE}          |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "\============================================/"
    sleep 5
}

function echo_race_menu() {
    clear
    echo -e "/============================================\\"
    echo -e "|               ${BGREEN}RACE SELECTION${NONE}               |"
    echo -e "|                                            |"
    echo -e "| $(if [ "$RACE" == "HUMAN" ]; then echo -e "${BRED}*)${NONE}"; else echo "1)"; fi) ${RED}HUMAN${NONE} - AVG HP & STM, * RND STATS       |"
    echo -e "|                                            |"
    echo -e "| $(if [ "$RACE" == "MLOK" ]; then echo -e "${BRED}*)${NONE}"; else echo "2)"; fi) ${CYAN}MLOK${NONE} - LESS HP, MORE STM + AGI          |"
    echo -e "|                                            |"
    echo -e "| $(if [ "$RACE" == "CAKE" ]; then echo -e "${BRED}*)${NONE}"; else echo "3)"; fi) ${YELLOW}CAKE${NONE} - MORE HP + STR, LESS STM + AGI    |"
    echo -e "|                                            |"
    echo -e "| $(if [ "$RACE" == "FISH" ]; then echo -e "${BRED}*)${NONE}"; else echo "4)"; fi) ${BLUE}FISH${NONE} - LESS *                           |"
    echo -e "|                                            |"
    echo -e "|                                  5) ${BGREEN}ACCEPT${NONE} |"
    echo -e "\============================================/"
}

function echo_class_menu() {
    clear
    echo -e "/============================================\\"
    echo -e "|              ${BGREEN}CLASS SELECTION${NONE}               |"
    echo -e "|                                            |"
    echo -e "| $(if [ "$CLASS" == "FIGHTER" ]; then echo -e "${BRED}*)${NONE}"; else echo "1)"; fi) ${BRED}FIGHTER${NONE} - +2 WPN DMG                    |"
    echo -e "|                                            |"
    echo -e "| $(if [ "$CLASS" == "CHEMIST" ]; then echo -e "${BRED}*)${NONE}"; else echo "2)"; fi) ${BGREEN}CHEMIST${NONE} - MORE ITEMS                    |"
    echo -e "|                                            |"
    echo -e "| $(if [ "$CLASS" == "GUARD" ]; then echo -e "${BRED}*)${NONE}"; else echo "3)"; fi) ${BBLUE}GUARD${NONE} - +2 DEF                          |"
    echo -e "|                                            |"
    echo -e "| $(if [ "$CLASS" == "PSYCHO" ]; then echo -e "${BRED}*)${NONE}"; else echo "4)"; fi) ${GRAY}PSYCHO${NONE} - LESS WPN STM                   |"
    echo -e "|                                            |"
    echo -e "|                                  5) ${BGREEN}ACCEPT${NONE} |"
    echo -e "\============================================/"
}

function echo_wpn_menu() {
    start_wpn1="$(display_wpn1.echo "wpn")"
    start_wpn2=$(display_wpn2.echo "wpn")
    start_wpn3=$(display_wpn3.echo "wpn")
    wpn_spaces="                                        "

    clear
    echo -e "/============================================\\"
    echo -e "|              ${BGREEN}WEAPON SELECTION${NONE}              |"
    echo -e "|                                            |"
    echo -e "| $(if [ $STRT_WPN -eq 1 ]; then echo -e "${BRED}*)${NONE}"; else echo "1)"; fi) $start_wpn1""${wpn_spaces::-${#start_wpn1}}""|"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "| $(if [ $STRT_WPN -eq 2 ]; then echo -e "${BRED}*)${NONE}"; else echo "2)"; fi) $start_wpn2""${wpn_spaces::-${#start_wpn2}}""|"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "| $(if [ $STRT_WPN -eq 3 ]; then echo -e "${BRED}*)${NONE}"; else echo "3)"; fi) $start_wpn3""${wpn_spaces::-${#start_wpn3}}""|"
    echo -e "|                                            |"
    echo -e "|                                  5) ${BGREEN}ACCEPT${NONE} |"
    echo -e "\============================================/"
}