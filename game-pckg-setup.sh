#!/bin/bash

pipboi_path=$(find / -type d -name "pipboi" 2>/dev/null)

if [ -n "$pipboi_path" ]; then
    echo pipboi exists
    mv "$PWD" "$pipboi_path"
    echo Succesfully integrated pipboi-game-pckg into PIPBOI system
else
    echo PIPBOI not installed
fi
