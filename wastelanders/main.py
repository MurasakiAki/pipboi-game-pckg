import configparser
import time
import os

def check_integration():
    config = configparser.ConfigParser()

    config.read('.game-pckg-config.ini')

    is_integrated_value = config.getint('Configuration', 'is_integrated')

    if is_integrated_value == 1:
        return True
    else:
        return False

def check_player(username):
    return os.path.exists(f"{os.getcwd()}/wastelanders/.{username}.ini")

def register(username, password):
    if check_player(username):
        print("Player already exists")
    else:
        try:
            with open(f"{os.getcwd()}/wastelanders/.{username}.ini", 'x') as file:
                file.write(f"[Data]\npassword={password}")
        except:
            pass
        print("New player created.")

def login(username, password):
    if check_player(username):

        player_config = configparser.ConfigParser()
        player_config.read('.{username}.ini')

        read_pass = player_config.getint('Data', 'password')

        if read_pass == password:
            print("login successful")
        else:
            print("invalid password")
print(check_player("aki"))
time.sleep(10)