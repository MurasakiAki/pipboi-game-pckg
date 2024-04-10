#!/bin/bash

source weapons.sh
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

ITEM_SLOT1=0
ITEM_SLOT2=0
ITEM_SLOT3=0

SLOT1_PRC=0
SLOT2_PRC=0
SLOT3_PRC=0

WPN1_PRC=0
WPN2_PRC=0
WPN3_PRC=0
SYR_PRC=0
MLT_PRC=0
SMB_PRC=0

function setup_shop() {
    init_shop_wpns
    ITEM_SLOT1=$(get_random_number 1 4)
    ITEM_SLOT2=$(get_random_number 1 4)
    ITEM_SLOT3=$(get_random_number 1 4)
    local wpn1_dmg=$(display_wpn1.quantity)
    local wpn2_dmg=$(display_wpn2.quantity)
    local wpn3_dmg=$(display_wpn3.quantity)

    WPN1_PRC=$(( (28 + wpn1_dmg) * ($LEVEL + $(get_random_number 1 3))))
    WPN2_PRC=$(( (25 + wpn2_dmg) * ($LEVEL + $(get_random_number 1 3))))
    WPN3_PRC=$(( (30 + wpn3_dmg) * ($LEVEL + $(get_random_number 1 3))))

    SYR_PRC=$((12 * $LEVEL))
    MLT_PRC=$((15 * $LEVEL))
    SMB_PRC=$((18 * $LEVEL))
}

function echo_shop_menu() {
    local player_caps="$(pad_with_zeros $SCORE)"
    local dis_wpn1_string=$(display_wpn1.echo "wpn")
    local dis_wpn2_string=$(display_wpn2.echo "wpn")
    local dis_wpn3_string=$(display_wpn3.echo "wpn")
    local syr=$(syringe.name)
    local mlt=$(molotov.name)
    local smb=$(smoke_bomb.name)
    local item_slot_spcs="                                        "

    local slot1_str=""
    local slot2_str=""
    local slot3_str=""

    case "$ITEM_SLOT1" in
        1)
            slot1_str=$dis_wpn1_string
            SLOT1_PRC=$WPN1_PRC
        ;;
        2)
            slot1_str=$syr
            SLOT1_PRC=$SYR_PRC
        ;;
        3)
            slot1_str=$mlt
            SLOT1_PRC=$MLT_PRC
        ;;
        4)
            slot1_str=$smb
            SLOT1_PRC=$SMB_PRC
        ;;
    esac

    case "$ITEM_SLOT2" in
        1)
            slot2_str=$dis_wpn2_string
            SLOT2_PRC=$WPN2_PRC
        ;;
        2)
            slot2_str=$syr
            SLOT2_PRC=$SYR_PRC
        ;;
        3)
            slot2_str=$mlt
            SLOT2_PRC=$MLT_PRC
        ;;
        4)
            slot2_str=$smb
            SLOT2_PRC=$SMB_PRC
        ;;
    esac

    case "$ITEM_SLOT3" in
        1)
            slot3_str=$dis_wpn3_string
            SLOT3_PRC=$WPN3_PRC
        ;;
        2)
            slot3_str=$syr
            SLOT3_PRC=$SYR_PRC
        ;;
        3)
            slot3_str=$mlt
            SLOT3_PRC=$MLT_PRC
        ;;
        4)
            slot3_str=$smb
            SLOT3_PRC=$SMB_PRC
        ;;
    esac

    local slot1_prc=$(pad_with_zeros $SLOT1_PRC)
    local slot2_prc=$(pad_with_zeros $SLOT2_PRC)
    local slot3_prc=$(pad_with_zeros $SLOT3_PRC)

    clear
    echo -e "/============================================\\"
    echo -e "|                    ${BGREEN}SHOP${NONE}                    |"
    echo -e "| YOUR CAPS:.........................${YELLOW}$player_caps${NONE}|"
    echo -e "| $(if [ "$SHOP_OPT" == "1" ]; then echo -e "${BRED}*)${NONE}"; else echo "1)"; fi) $slot1_str""${item_slot_spcs::-${#slot1_str}}""|"
    echo -e "| CAPS:..............................${YELLOW}$slot1_prc${NONE}|"
    echo -e "|                                            |"
    echo -e "| $(if [ "$SHOP_OPT" == "2" ]; then echo -e "${BRED}*)${NONE}"; else echo "2)"; fi) $slot2_str""${item_slot_spcs::-${#slot2_str}}""|"
    echo -e "| CAPS:..............................${YELLOW}$slot2_prc${NONE}|"
    echo -e "|                                            |"
    echo -e "| $(if [ "$SHOP_OPT" == "3" ]; then echo -e "${BRED}*)${NONE}"; else echo "3)"; fi) $slot3_str""${item_slot_spcs::-${#slot3_str}}""|"
    echo -e "| CAPS:..............................${YELLOW}$slot3_prc${NONE}|"
    echo -e "|        4) BUY               5) DONE        |"
    echo -e "\============================================/"
}