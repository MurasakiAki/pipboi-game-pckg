#!/bin/bash

. system.h
. character.h

source menu.sh

LEVEL=1

# init player

echo_menu

character player
player.init "aki" 100 20

character enemy
enemy.init "zombie" 20 5

until [ "$(player.current_health)" -lt "0" ] || [ "$(player.current_health)" == "0" ]; do

    player.current_health = $(($(player.current_health)-12))
    player.current_health
done
