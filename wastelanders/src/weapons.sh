#!/bin/bash

function init_starting_wpns() {
    display_wpn1.init "$(get_random_wpn_name)" "$(get_random_number 4 $(player.max_stamina))" "$(get_random_number 7 12)"
    display_wpn2.init "$(get_random_wpn_name)" "$(get_random_number 8 $(player.max_stamina))" "$(get_random_number 10 13)"
    display_wpn3.init "$(get_random_wpn_name)" "$(get_random_number 5 $(player.max_stamina))" "$(get_random_number 5 15)"
    if [ "$CLASS" == "FIGHTER" ]; then
        local d_wpn1_dmg=$(display_wpn1.quantity)
        local d_wpn2_dmg=$(display_wpn2.quantity)
        local d_wpn3_dmg=$(display_wpn3.quantity)

        display_wpn1.quantity = $(($d_wpn1_dmg + 2))
        display_wpn2.quantity = $(($d_wpn2_dmg + 2))
        display_wpn3.quantity = $(($d_wpn3_dmg + 2))
    elif [ "$CLASS" == "PSYCHO" ]; then
        local d_wpn1_spu=$(display_wpn1.stm_per_use)
        local d_wpn2_spu=$(display_wpn2.stm_per_use)
        local d_wpn3_spu=$(display_wpn3.stm_per_use)

        display_wpn1.stm_per_use = $(($d_wpn1_spu - 2))
        display_wpn2.stm_per_use = $(($d_wpn2_spu - 2))
        display_wpn3.stm_per_use = $(($d_wpn3_spu - 2))
    fi
}

function init_shop_wpns() {
    local p_max_stm=$(player.max_stamina)
    display_wpn1.init "$(get_random_wpn_name)" "$(($(get_random_number 4 $p_max_stm) * $LEVEL))" "$(($(get_random_number 7 12) * $LEVEL))"
    display_wpn2.init "$(get_random_wpn_name)" "$(($(get_random_number 8 $p_max_stm) * $LEVEL))" "$(($(get_random_number 10 13) * $LEVEL))"
    display_wpn3.init "$(get_random_wpn_name)" "$(($(get_random_number 5 $p_max_stm) * $LEVEL))" "$(($(get_random_number 5 15) * $LEVEL))"
    if [ "$CLASS" == "FIGHTER" ]; then
        local d_wpn1_dmg=$(display_wpn1.quantity)
        local d_wpn2_dmg=$(display_wpn2.quantity)
        local d_wpn3_dmg=$(display_wpn3.quantity)

        display_wpn1.quantity = $(($d_wpn1_dmg + 2))
        display_wpn2.quantity = $(($d_wpn2_dmg + 2))
        display_wpn3.quantity = $(($d_wpn3_dmg + 2))
    elif [ "$CLASS" == "PSYCHO" ]; then
        local d_wpn1_spu=$(display_wpn1.stm_per_use)
        local d_wpn2_spu=$(display_wpn2.stm_per_use)
        local d_wpn3_spu=$(display_wpn3.stm_per_use)

        display_wpn1.stm_per_use = $(($d_wpn1_spu - 2))
        display_wpn2.stm_per_use = $(($d_wpn2_spu - 2))
        display_wpn3.stm_per_use = $(($d_wpn3_spu - 2))
    fi
}
