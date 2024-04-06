#!/bin/bash

function check_stat() {
    stat=$1
    if [ "$stat" -gt "100" ]; then
        stat="100"
        echo $stat
    else
        echo $stat
    fi
}

function chcek_lvl_stat() {
    lvl_stat=$1
    if [ "$lvl_stat" -gt "99999999" ]; then
        lvl_stat="99999999"
        echo $lvl_stat
    else
        echo $lvl_stat
    fi
}

function check_health() {
    health=$1
    if [ "$health" -gt "999" ]; then
        health="999"
        echo $health
    else
        echo $health
    fi
}

function check_stamina() {
    stamina=$1
    if [ "$stamina" -gt "99" ]; then
        stamina="99"
        echo $stamina
    else
        echo $stamina
    fi
}

function check_item() {
    item=$1
    if [ "$item" -gt "9" ]; then
        item="9"
        echo $item
    else
        echo $item
    fi
}