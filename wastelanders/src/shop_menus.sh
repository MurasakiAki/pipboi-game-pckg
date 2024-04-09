#!/bin/bash

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

function echo_shop_menu() {
    local player_caps="$(pad_with_zeros $SCORE)"
    clear
    echo -e "/============================================\\"
    echo -e "|                    ${BGREEN}SHOP${NONE}                    |"
    echo -e "| YOUR CAPS:.........................${YELLOW}$player_caps${NONE}|"
    echo -e "| 1)                                         |"
    echo -e "| CAPS:..............................|"
    echo -e "|                                            |"
    echo -e "| 2)                                         |"
    echo -e "| CAPS:..............................|"
    echo -e "|                                            |"
    echo -e "| 3)                                         |"
    echo -e "| CAPS:..............................|"
    echo -e "|        4) BUY               5) DONE        |"
    echo -e "\============================================/"
}