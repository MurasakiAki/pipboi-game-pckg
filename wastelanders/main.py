import configparser
import time
import os
import bcrypt
import getpass

LOGGED_IN_USR = ""

def hash_password(password):
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')

def check_password(input_password, hashed_password):
    return bcrypt.checkpw(input_password.encode('utf-8'), hashed_password.encode('utf-8'))

def check_player(username):
    return os.path.exists(f"{os.getcwd()}/wastelanders/characters/.{username}.ini")

def register(username, password):
    if check_player(username):
        print("Player already exists")
    else:
        try:
            with open(f"{os.getcwd()}/wastelanders/characters/.{username}.ini", 'x') as file:
                file.write(f"[Data]\npassword = {hash_password(password)}\nhi-score = 0")
        except:
            pass
        LOGGED_IN_USR = username
        print("New player created.")

def login(username, password):
    if check_player(username):
        read_pass = read_ini(f"wastelanders/characters/.{username}.ini", 'Data', 'password', "s")

        if check_password(password, read_pass):
            print("login successful")
            return True
        else:
            print("invalid password")
            return False

while True:
    os.system('clear')
    print("Welcome to Wastelanders!")
    time.sleep(5)
    while True:
        time.sleep(1)
        os.system('clear')
        choice = input("Do you want to [L]ogin or [r]egister?\n")
        if choice in ["", "L", "l", "login", "log"]:
            print("Please log in:")
            usrnm = input("Username: ")
            psswd = getpass.getpass("Password: ")
            if login(usrnm, psswd):
                LOGGED_IN_USR = usrnm
                break
            else:
                pass
        elif choice in ["R", "r", "reg", "register"]:
            print("Please register:")
            usrnm = input("Username: ")
            psswd = getpass.getpass("Password: ")
            register(usrnm, psswd)
            login(usrnm, psswd)
            break
        else:
            print("Wrong choice")

    break

time.sleep(2)

while True:
    os.system('clear')
    print("=======================")
    print("|                     |")
    print("|1) PLAY              |")
    print("|2) OPTIONS           |")
    print("|3) QUIT              |")
    print("|                     |")
    print("=======================")
    try:
        go_to = int(input("What do you want to do?\n"))
    except ValueError:
        pass

    if go_to == 1:
        os.system('clear')
        print("game start")
        break
    elif go_to == 2:
        print("there should be options")
    elif go_to == 3:
        print("=======================")
        print("|                     |")
        print("|                     |")
        print("|       Bye bye       |")
        print("|                     |")
        print("|                     |")
        print("=======================")
        break