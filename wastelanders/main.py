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
    return os.path.exists(f"{os.getcwd()}/wastelanders/.{username}")

def register(username, password):
    pass

def login(username, password):
    pass

print(check_player("aki"))
time.sleep(10)