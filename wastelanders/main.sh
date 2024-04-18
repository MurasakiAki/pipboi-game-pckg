#!/bin/bash

PLAYER_NAME=$1

export SRC_PATH="$(dirname "$0")/src"

bash $SRC_PATH/game.sh "$PLAYER_NAME"