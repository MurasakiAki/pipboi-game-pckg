#!/bin/bash

pipboi_path=$(find / -type d -name "pipboi" 2>/dev/null)

if [ -n "$pipboi_path" ]; then
    echo "PIPBOI exists"
    for game in */ ; do
        if [ -d "$game" ]; then
            mv "$game" "$pipboi_path/mods"
            echo "Moved $game to $pipboi_path/mods"
        fi
    done
    echo "Successfully integrated pipboi-game-pckg into PIPBOI system"
else
    echo "PIPBOI not installed"
fi
