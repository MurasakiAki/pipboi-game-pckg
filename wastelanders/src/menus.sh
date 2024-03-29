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

function echo_menu() {
    player_name=$(player.name)
    player_chealth=$(player.current_health)
    player_cstamina=$(player.current_stamina)
    player_name_len=${#player_name}
    player_name_line="| $player_name                                 "
    player_name_line="${player_name_line:0:$((${#player_name_line} - $player_name_len))}"
    
    health_space="                       "
    if [ ${#player_chealth} -eq 2 ]; then
        health_space="$health_space "
    elif [ ${#player_chealth} -eq 1 ]; then
        health_space="$health_space  "
    fi

    stamina_space="                        "
    if [ ${#player_cstamina} -eq 1 ]; then
        health_space="$health_space "
    fi

    clear
    echo -e "/============================================\\"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|--------------------------------------------|"
    echo -e "$player_name_line""|  ${BBLUE}ITEMS${NONE}  |"
    echo -e "| HP:${BRED}$(player.current_health)/$(player.max_health)${NONE}$health_space| ${BRED}SYR${NONE} "$(syringe.quantity)"/9 |"
    echo -e "| STM:${BGREEN}$(player.current_stamina)/$(player.max_stamina)${NONE}                        | ${GRAY}SMB${NONE} "$(smoke_bomb.quantity)"/9 |"
    echo -e "| 1) ${RED}ATTACK${NONE}   3) ${BLUE}DEFEND${NONE}   5) ${GRAY}USE${NONE}   | ${ORANGE}MLT${NONE} "$(molotov.quantity)"/9 |"
    echo -e "| 2) ${BRED}HEAL${NONE}     4) ${YELLOW}RUN${NONE}      6) ${CYAN}INFO${NONE}  |         |"
    echo -e "\============================================/"

}

function echo_info_menu() {
    lines=($@)
    clear_lines="                              "
    clear
    echo -e "/============================================\\"
    line="${lines[0]}"
    echo $line
    echo -e "| ${CYAN}INFO MENU${NONE}  | '${lines[0]}${clear_lines::-${#line}}|'"
    echo -e "| 1) ${RED}ENEMY${NONE}   |                               |"
    echo -e "| 2) ${BRED}SYR${NONE}     |                               |"
    echo -e "| 3) ${GRAY}SMB${NONE}     |                               |"
    echo -e "| 4) ${ORANGE}MLT${NONE}     |                               |"
    echo -e "| 5) ${BLUE}DEFEND${NONE}  |                               |"
    echo -e "| 6) ${YELLOW}RUN${NONE}     |                               |"
    echo -e "|            |                               |"
    echo -e "|            |                               |"
    echo -e "| 7) ${GRAY}BACK${NONE}    |                               |"
    echo -e "| 8) ${BRED}QUIT${NONE}    |                               |"
    echo -e "\============================================/"
}