#!/bin/bash

source shop_menus.sh

function buy() {
    local itm_to_buy=$1

    case "$itm_to_buy" in
        W1) echo "w1" ;;
        W2) echo "w2" ;;
        W3) echo "w3" ;;
        2) echo "2" ;;
        3) echo "3" ;;
        4) echo "4" ;;
    esac

}

function shop() {
    setup_shop
    echo_shop_menu
    local will_buy=""
    local is_done=0
    until [ $is_done -eq 1 ]; do
        read -rsn 1 SHOP_OPT
        case "$SHOP_OPT" in
            1) 
                case "$ITEM_SLOT1" in
                    1) will_buy="W1" ;;
                    2) will_buy="2" ;;
                    3) will_buy="3" ;;
                    4) will_buy="4" ;;
                esac
                echo_shop_menu
            ;;
            2)
                case "$ITEM_SLOT2" in
                    1) will_buy="W2" ;;
                    2) will_buy="2" ;;
                    3) will_buy="3" ;;
                    4) will_buy="4" ;;
                esac
                echo_shop_menu
            ;;
            3)
                case "$ITEM_SLOT3" in
                    1) will_buy="W3" ;;
                    2) will_buy="2" ;;
                    3) will_buy="3" ;;
                    4) will_buy="4" ;;
                esac
                echo_shop_menu
            ;;
            4) buy "$will_buy"
            ;;
            5) 
                is_done=1 
            ;;
        esac
    done
}