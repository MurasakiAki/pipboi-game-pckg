from main import read_ini, write_ini

PLAYER_FILE_DIR = "wastelanders/characters/"

def fill_rc_stats(usrnm, hp, stmn, str, dex, per, agi):
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','Stats', 'health', hp)
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','Stats', 'stamina', stmn)
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','Stats', 'STR', str) # increases large weapons, health
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','Stats', 'DEX', dex) # increases small weapons
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','Stats', 'PER', per) # increases guns
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','Stats', 'AGI', agi) # determines successful evade, number of actions per turn(stamina)

def fill_clss_stats(usrnm, mn, bckpck):
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','INV', 'money', mn)
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','INV', 'backpack', bckpck)

def create_character(usrnm, rc, clss):
    # Base Stats
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','Stats', 'race', rc)
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','Stats', 'class', clss)
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','Stats', 'exp', 0)
    write_ini(f'{PLAYER_FILE_DIR}.{usrnm}.ini','Stats', 'level', 0)

    # Clss/RC based stats
    if rc == "human":
        fill_rc_stats(usrnm, 100, 100, 5, 5, 5, 5, 100)
    elif rc == "loli":
        fill_rc_stats(usrnm, 80, 150, 1, 6, 6, 8, 150)
    elif rc == "mlok":
        fill_rc_stats(usrnm, 50, 150, 5, 7, 3, 8, 100)
    elif rc == "skeli":
        fill_rc_stats(usrnm, 150, 80, 8, 1, 8, 1, 50)

    bckpck = ""
    if clss == "soldier":
        fill_clss_stats(usrnm, 100, f"{bckpck}|W_M_L_BroadSword_(12-16)_(1)")
    elif clss == "gunner":
        fill_clss_stats(usrnm, 80, bckpck)
    elif clss == "sniper":
        fill_clss_stats(usrnm, 50, f"{bckpck}|I_T_SmokeBomb_1-2_0_5_200_0_F")
    elif clss == "chemist":
        fill_clss_stats(usrnm, 10, backpack)
    elif clss == "psycho":
        fill_clss_stats(usrnm, 0, bckpck)

def init_world(type):
    pass
