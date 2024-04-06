#!/bin/bash

LOGGED_IN_USR=""

hash_password() {
    local password=$1
    local salt=$(openssl rand -base64 12)
    local hashed_password=$(echo -n "$password$salt" | openssl sha512 -binary | base64)
    echo "$hashed_password"
}

check_password() {
    local input_password=$1
    local hashed_password=$2
    local salt=${hashed_password:88}
    local new_hash=$(echo -n "$input_password$salt" | openssl sha512 -binary | base64)
    [[ "$hashed_password" == "$new_hash" ]]
}

check_user() {
    local username=$1
    [[ -f "users/.$username.ini" ]]
}

register() {
    local username=$1
    local password=$2
    if check_user "$username"; then
        echo "User already exists, please login"
    else
        touch "users/.$username.ini"
        if { echo -e "[Data]\npassword = $(hash_password "$password")\nhi-score = 0"; } > "users/.$username.ini"; then
            LOGGED_IN_USR=$username
            echo "New player created."
        fi
    fi
}

login() {
    local username=$1
    local password=$2
    if check_user "$username"; then
        read_pass=$(awk -F= '/password/ {print $2}' "users/.$username.ini")
        if check_password "$password" "$read_pass"; then
            echo "login successful"
            return 0
        else
            echo "invalid password"
            return 1
        fi
    fi
}

while true; do
    echo_welcome
    while true; do
        clear
        read -p "Do you want to [L]ogin or [r]egister? " choice
        case $choice in
            [lL]*)
                echo "Please log in:"
                read -p "Username: " usrnm
                read -s -p "Password: " psswd
                echo
                if login "$usrnm" "$psswd"; then
                    LOGGED_IN_USR=$usrnm
                    break 2
                fi
                ;;
            [rR]*)
                echo "Please register:"
                read -p "Username: " usrnm
                read -s -p "Password: " psswd
                echo
                register "$usrnm" "$psswd"
                login "$usrnm" "$psswd"
                break 2
                ;;
            *)
                echo "Wrong choice"
                ;;
        esac
    done
done

sleep 2

while true; do
    clear
    cat <<EOF
=======================
|                     |
|1) PLAY              |
|2) OPTIONS           |
|3) QUIT              |
|                     |
=======================
EOF
    read -p "What do you want to do? " go_to
    case $go_to in
        1)
            clear
            cd src
            bash game.sh
            ;;
        2)
            echo "there should be options"
            ;;
        3)
            clear
            cat <<EOF
=======================
|                     |
|                     |
|       Bye bye       |
|                     |
|                     |
=======================
EOF
            break
            ;;
    esac
done
