#!/bin/bash

#how many percentage from number
calculate_percentage() {
    local number="$1"
    local percentage="$2"
    echo "$(( (number * percentage) / 100 ))"
}

function get_random_number() {
    if [ "$#" -eq 0 ]; then
        start_rnd=1
        end_rnd=10
        random_number=$(( RANDOM % (end_rnd - start_rnd + 1) + start_rnd ))
        echo "$random_number"
    elif [ "$#" -eq "2" ]; then
        start_rnd=$1
        end_rnd=$2
        random_number=$(( RANDOM % (end_rnd - start_rnd + 1) + start_rnd ))
        echo "$random_number"
    else
        echo "Wrong arguments in get_random_number function."
        exit 1
    fi
}
