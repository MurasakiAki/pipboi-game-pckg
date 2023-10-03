import configparser
import time

def check_integration():
    config = configparser.ConfigParser()

    config.read('.game-pckg-config.ini')

    is_integrated_value = config.getint('Configuration', 'is_integrated')

    if is_integrated_value == 1:
        return True
    else:
        return False


print(check_integration())
time.sleep(10)