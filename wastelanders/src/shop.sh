#!/bin/bash

source checks.sh
source shop_menus.sh

function buy() {
    local itm_to_buy=$1

    case "$itm_to_buy" in
        W1)
            if [ $(check_price $SCORE $WPN1_PRC) -eq 1 ] && [ $S1_IS_BOUGHT -eq 0 ]; then
                SCORE=$((SCORE - WPN1_PRC))
                weapon.init "$(display_wpn1.name)" "$(display_wpn1.stm_per_use)" "$(display_wpn1.quantity)"
                S1_IS_BOUGHT=1
            fi
        ;;
        W2) 
            if [ $(check_price $SCORE $WPN2_PRC) -eq 1 ] && [ $S2_IS_BOUGHT -eq 0 ]; then
                SCORE=$((SCORE - WPN2_PRC))
                weapon.init "$(display_wpn2.name)" "$(display_wpn2.stm_per_use)" "$(display_wpn2.quantity)"
                S2_IS_BOUGHT=1
            fi
        ;;
        W3)
            if [ $(check_price $SCORE $WPN3_PRC) -eq 1 ] && [ $S3_IS_BOUGHT -eq 0 ]; then
                SCORE=$((SCORE - WPN3_PRC))
                weapon.init "$(display_wpn3.name)" "$(display_wpn3.stm_per_use)" "$(display_wpn3.quantity)"
                S3_IS_BOUGHT=1
            fi
        ;;
        2)
            if [ $(check_price $SCORE $SYR_PRC) -eq 1 ] && [ $(check_item $(syringe.quantity)) -lt 9 ]; then
                SCORE=$((SCORE - SYR_PRC))
                syr_qnt=$(syringe.quantity)
                syr_qnt=$((syr_qnt + 1))
                syr_qnt=$(check_item $syr_qnt)
                syringe.quantity = $((syr_qnt + 1))
            fi
        ;;
        3)
            if [ $(check_price $SCORE $MLT_PRC) -eq 1 ] && [ $(check_item $(molotov.quantity)) -lt 9 ]; then
                SCORE=$((SCORE - MLT_PRC))
                mlt_qnt=$(molotov.quantity)
                mlt_qnt=$((mlt_qnt + 1))
                mlt_qnt=$(check_item $mlt_qnt)
                molotov.quantity = $mlt_qnt
            fi
        ;;
        4)
            if [ $(check_price $SCORE $SMB_PRC) -eq 1 ] && [ $(check_item $(smoke_bomb.quantity)) -lt 9 ]; then
                SCORE=$((SCORE - SMB_PRC))
                smb_qnt=$(smoke_bomb.quantity)
                smb_qnt=$((smb_qnt + 1))
                smb_qnt=$(check_item $smb_qnt)
                smoke_bomb.quantity = $smb_qnt
            fi
        ;;
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
            4) 
                buy "$will_buy"
                echo_shop_menu
            ;;
            5) 
                is_done=1 
            ;;
        esac
    done
}