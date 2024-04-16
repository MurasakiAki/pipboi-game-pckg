#!/bin/bash

function do_score_update() {
    if [ "$#" -ne 3 ]; then
        echo "Usage: $0 <json_file> <player_name> <game_score>"
        exit 1
    fi

    json_file=$1
    player_name=$2
    game_score=$3

    if [ ! -f "$json_file" ]; then
        echo "Error: JSON file '$json_file' not found."
        exit 1
    fi

    if ! command -v jq &> /dev/null; then
        echo "Error: 'jq' command not found. Please install jq."
        exit 1
    fi

    player_exists=$(jq --arg name "$player_name" '.[$name]' "$json_file")

    if [ -z "$player_exists" ]; then
        jq --arg name "$player_name" --arg score "$game_score" '.[$name] = { "wastelanders": $score }' "$json_file" > "$json_file.tmp"
        mv "$json_file.tmp" "$json_file"
        echo "Added player '$player_name' with game score '$game_score'."
    else
        saved_score=$(jq --arg name "$player_name" '.[$name].wastelanders' "$json_file")
        if [ "$game_score" -gt "$saved_score" ]; then
            jq --arg name "$player_name" --arg score "$game_score" '.[$name].wastelanders = $score' "$json_file" > "$json_file.tmp"
            mv "$json_file.tmp" "$json_file"
            echo "Updated score for player '$player_name' to '$game_score'."
        else
            echo "Score for player '$player_name' is already higher or equal to '$game_score'."
        fi
    fi
}