#!/bin/bash

# Function to register a new user
register() {
    read -p "Enter your username: " username
    read -s -p "Enter your password: " password
    echo ""
    echo "$password" > "users/$username.ini"
    echo "User registered successfully!"
}

# Function to login
login() {
    read -p "Enter your username: " username
    read -s -p "Enter your password: " password
    echo ""
    stored_password=$(< "users/$username.ini")
    if [ "$password" = "$stored_password" ]; then
        echo "Login successful!"
        game_menu
    else
        echo "Invalid username or password."
    fi
}

# Function for the game menu
game_menu() {
    echo "Welcome to the game!"
    PS3="Please choose an option: "
    options=("Play" "Options" "Exit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Play")
                echo "Starting the game..."
                # Add your game logic here
                ;;
            "Options")
                echo "Options menu..."
                # Add your options logic here
                ;;
            "Exit")
                echo "Goodbye!"
                exit 0
                ;;
            *) echo "Invalid option";;
        esac
    done
}

# Main script starts here

# Create users folder if it doesn't exist
mkdir -p users

echo "Welcome to the user login/register system!"

while true; do
    read -p "Do you want to (R)egister or (L)ogin? " choice
    case $choice in
        [Rr]* )
            register
            ;;
        [Ll]* )
            login
            ;;
        * )
            echo "Please enter 'R' for register or 'L' for login."
            ;;
    esac
done
