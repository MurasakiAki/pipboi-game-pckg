#!/bin/bash

# Define the number of random characters you want to generate
num_characters=10

function randomize() {
    until [ "$ite" == "100" ]; do
        clear
        ite="0"
        random_characters=$(LC_ALL=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c $num_characters)
        echo "$random_characters"
        ite="$(("ite + 1"))"
        echo "$ite"
    done
}

randomize