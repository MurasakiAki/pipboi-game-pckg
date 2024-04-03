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

generate_name_line() {
    local name="$1"
    local name_length="${#name}"
    local name_line="| $name"
    local padding=$((33 - name_length))

    name_line+="$(printf "%${padding}s")"
    
    echo "$name_line"
}

function echo_menu() {
    player_name=$(player.name)
    player_chealth=$(player.current_health)
    player_cstamina=$(player.current_stamina)
    player_name_line="$(generate_name_line "$player_name")"
    player_str=$(player.STR)
    player_per=$(player.PER)
    player_dex=$(player.DEX)
    player_agi=$(player.AGI)

    enemy_name=$(enemy.name)
    enemy_max_hp=$(enemy.max_health)
    enemy_chealth=$(enemy.current_health)
    enemy_max_stm=$(enemy.max_stamina)
    enemy_cstamina=$(enemy.current_stamina)
    enemy_name_line="$(generate_name_line "$enemy_name")"
    enemy_str=$(enemy.STR)
    enemy_per=$(enemy.PER)
    enemy_dex=$(enemy.DEX)
    enemy_agi=$(enemy.AGI)

    p_health_space="  "
    if [ ${#player_chealth} -eq 2 ]; then
        p_health_space="$p_health_space "
    elif [ ${#player_chealth} -eq 1 ]; then
        p_health_space="$p_health_space  "
    fi

    p_stamina_space="   "
    if [ ${#player_cstamina} -eq 3 ]; then
        p_stamina_space="${p_stamina_space::-2}"
    elif [ ${#player_cstamina} -eq 1 ]; then
        p_stamina_space="$p_stamina_space "
    fi

    e_health_space="    "
    if [ ${#enemy_chealth} -eq 3 ]; then
        e_health_space="${e_health_space::-2}"
    elif [ ${#enemy_chealth} -eq 1 ] && [ ${#enemy_max_hp} -gt 1 ]; then
        e_health_space="$e_health_space "
    elif [ ${#enemy_chealth} -eq 1 ] && [ ${#enemy_max_hp} -eq 1 ]; then
        e_health_space="$e_health_space  "
    fi

    e_stamina_space="   "
    if [ ${#enemy_cstamina} -eq 3 ]; then
        e_stamina_space="${e_stamina_space::-2}"
    elif [ ${#enemy_cstamina} -eq 1 ] && [ ${#enemy_max_stm} -gt 1 ]; then
        e_stamina_space="$e_stamina_space "
    elif [ ${#enemy_cstamina} -eq 1 ] && [ ${#enemy_max_stm} -eq 1 ]; then
        e_stamina_space="$e_stamina_space  "
    fi

    str_per_spaces="        "
    dex_agi_spaces="     "

    clear
    echo -e "/============================================\\"
    echo -e "$(if [ "$(enemy.is_defending)" -eq "1" ]; then echo "${BLUE}$enemy_name_line${NONE}"; else echo "$enemy_name_line"; fi)""|         |"
    echo -e "| HP:${BRED}$(enemy.current_health)/$(enemy.max_health)${NONE}""$e_health_space""STR:$enemy_str""${str_per_spaces::-${#enemy_str}}""DEX:$enemy_dex""${dex_agi_spaces::-${#enemy_dex}}""|         |"
    echo -e "| STM:${BGREEN}$(enemy.current_stamina)/$(enemy.max_stamina)${NONE}""$e_stamina_space""PER:$enemy_per""${str_per_spaces::-${#enemy_per}}""AGI:$enemy_agi""${dex_agi_spaces::-${#enemy_agi}}""|         |"
    echo -e "|                                  |         |"
    echo -e "|                                  |         |"
    echo -e "|--------------------------------------------|"
    echo -e "$(if [ "$(player.is_defending)" -eq "1" ]; then echo "${BLUE}$player_name_line${NONE}"; else echo "$player_name_line"; fi)""|  ${BBLUE}ITEMS${NONE}  |"
    echo -e "| HP:${BRED}$(player.current_health)/$(player.max_health)${NONE}""$p_health_space""STR:$player_str""${str_per_spaces::-${#player_str}}""DEX:$player_dex""${dex_agi_spaces::-${#player_dex}}""| ${BRED}SYR${NONE} "$(syringe.quantity)"/9 |"
    echo -e "| STM:${BGREEN}$(player.current_stamina)/$(player.max_stamina)${NONE}""$p_stamina_space""PER:$player_per""${str_per_spaces::-${#player_per}}""AGI:$player_agi""${dex_agi_spaces::-${#player_agi}}""| ${GRAY}SMB${NONE} "$(smoke_bomb.quantity)"/9 |"
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

function echo_players_turn() {
    clear
    echo -e "/============================================\\"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                ${BGREEN}PLAYERS TURN${NONE}                |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "\============================================/"
    sleep 2
}

function echo_enemy_turn() {
    clear
    echo -e "/============================================\\"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                 ${RED}ENEMY TURN${NONE}                 |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "\============================================/"
    sleep 2
}

function echo_enemy_defeated() {
    clear
    echo -e "/============================================\\"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|               ${BRED}ENEMY DEFEATED${NONE}               |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "\============================================/"
    sleep 2
}

function echo_use_menu() {
    clear
    echo -e "/============================================\\"
    echo -e "$(if [ "$(enemy.is_defending)" -eq "1" ]; then echo "${BLUE}$enemy_name_line${NONE}"; else echo "$enemy_name_line"; fi)""|         |"
    echo -e "| HP:${BRED}$(enemy.current_health)/$(enemy.max_health)${NONE}""$e_health_space""STR:$enemy_str""${str_per_spaces::-${#enemy_str}}""DEX:$enemy_dex""${dex_agi_spaces::-${#enemy_dex}}""|         |"
    echo -e "| STM:${BGREEN}$(enemy.current_stamina)/$(enemy.max_stamina)${NONE}""$e_stamina_space""PER:$enemy_per""${str_per_spaces::-${#enemy_per}}""AGI:$enemy_agi""${dex_agi_spaces::-${#enemy_agi}}""|         |"
    echo -e "|                                  |         |"
    echo -e "|                                  |         |"
    echo -e "|--------------------------------------------|"
    echo -e "$(if [ "$(player.is_defending)" -eq "1" ]; then echo "${BLUE}$player_name_line${NONE}"; else echo "$player_name_line"; fi)""|  ${BBLUE}ITEMS${NONE}  |"
    echo -e "| HP:${BRED}$(player.current_health)/$(player.max_health)${NONE}""$p_health_space""STR:$player_str""${str_per_spaces::-${#player_str}}""DEX:$player_dex""${dex_agi_spaces::-${#player_dex}}""| ${BRED}SYR${NONE} "$(syringe.quantity)"/9 |"
    echo -e "| STM:${BGREEN}$(player.current_stamina)/$(player.max_stamina)${NONE}""$p_stamina_space""PER:$player_per""${str_per_spaces::-${#player_per}}""AGI:$player_agi""${dex_agi_spaces::-${#player_agi}}""| ${GRAY}SMB${NONE} "$(smoke_bomb.quantity)"/9 |"
    echo -e "| 1) ${ORANGE}MLT${NONE}      2) ${GRAY}SMB${NONE}      3) ${GRAY}BACK${NONE}  | ${ORANGE}MLT${NONE} "$(molotov.quantity)"/9 |"
    echo -e "|                                  |         |"
    echo -e "\============================================/"
}