#!/bin/bash

calculate_percentage() {
    local number="$1"
    local percentage="$2"
    echo "$(( (number * percentage) / 100 ))"
}

echo "$(calculate_percentage 10 25)"