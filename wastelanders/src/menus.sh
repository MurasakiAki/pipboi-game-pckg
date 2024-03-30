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

split_string() {
    local str="$1"
    local max_length=30
    local current_chunk=""
    local words=()
    local split_parts=()

    IFS=' ' read -ra words <<< "$str"

    for word in "${words[@]}"; do
        if (( ${#current_chunk} + ${#word} <= max_length )); then
            if [ -z "$current_chunk" ]; then
                current_chunk="$word"
            else
                current_chunk+=" $word"
            fi
        else
            split_parts+=("$current_chunk")
            current_chunk="$word"
        fi
    done

    if [ -n "$current_chunk" ]; then
        split_parts+=("$current_chunk")
    fi

    echo "${split_parts[@]}"
}

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
    lines=("$@")
    clear_lines="                              "
    clear
    echo -e "/============================================\\"
    echo -e "| ${CYAN}INFO MENU${NONE}  | ${GRAY}${lines[0]}$(if [ "${lines[0]}" == "" ]; then printf "%s" "$clear_lines"; else echo "${clear_lines::-${#lines[0]}}"; fi)${NONE}|"
    echo -e "| 1) ${RED}ENEMY${NONE}   | ${lines[1]}$(if [ "${lines[1]}" == "" ]; then printf "%s" "$clear_lines"; else echo "${clear_lines::-${#lines[1]}}"; fi)|"
    echo -e "| 2) ${BRED}SYR${NONE}     | ${lines[2]}$(if [ "${lines[2]}" == "" ]; then printf "%s" "$clear_lines"; else echo "${clear_lines::-${#lines[2]}}"; fi)|"
    echo -e "| 3) ${GRAY}SMB${NONE}     | ${lines[3]}$(if [ "${lines[3]}" == "" ]; then printf "%s" "$clear_lines"; else echo "${clear_lines::-${#lines[3]}}"; fi)|"
    echo -e "| 4) ${ORANGE}MLT${NONE}     | ${lines[4]}$(if [ "${lines[4]}" == "" ]; then printf "%s" "$clear_lines"; else echo "${clear_lines::-${#lines[4]}}"; fi)|"
    echo -e "| 5) ${BLUE}DEFEND${NONE}  | ${lines[5]}$(if [ "${lines[5]}" == "" ]; then printf "%s" "$clear_lines"; else echo "${clear_lines::-${#lines[5]}}"; fi)|"
    echo -e "| 6) ${YELLOW}RUN${NONE}     | ${lines[6]}$(if [ "${lines[6]}" == "" ]; then printf "%s" "$clear_lines"; else echo "${clear_lines::-${#lines[6]}}"; fi)|"
    echo -e "|            | ${lines[7]}$(if [ "${lines[7]}" == "" ]; then printf "%s" "$clear_lines"; else echo "${clear_lines::-${#lines[7]}}"; fi)|"
    echo -e "|            | ${lines[8]}$(if [ "${lines[8]}" == "" ]; then printf "%s" "$clear_lines"; else echo "${clear_lines::-${#lines[8]}}"; fi)|"
    echo -e "| 7) ${GRAY}BACK${NONE}    | ${lines[9]}$(if [ "${lines[9]}" == "" ]; then printf "%s" "$clear_lines"; else echo "${clear_lines::-${#lines[9]}}"; fi)|"
    echo -e "| 8) ${BRED}QUIT${NONE}    | ${lines[10]}$(if [ "${lines[10]}" == "" ]; then printf "%s" "$clear_lines"; else echo "${clear_lines::-${#lines[10]}}"; fi)|"
    echo -e "\============================================/"
}