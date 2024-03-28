#!/bin/bash

. system.h
. character.h

LEVEL=1

# init player

character player
player.init "aki" 100 20
player.echo

character enemy
enemy.init "zombie" 20 5
enemy.echo
