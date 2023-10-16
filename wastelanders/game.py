from main import read_ini, write_ini

def fill_rc_stats(usrnm, hp, stmn, str, dex, per, agi, spt_dst):
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'health', hp)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'stamina', stmn)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'STR', str)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'DEX', dex)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'PER', per)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'AGI', agi)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'spot_dist', spt_dst)

def fill_clss_stats(usrn, mss, bckpck, hd, chst, lgs, lft_hnd, rght_hnd):
    

def create_character(usrnm, rc, clss):
    # Base Stats
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'race', rc)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'class', clss)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'exp', 0)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'level', 1)

    # Clss/RC based stats
    if rc == "human":
        fill_rc_stats(usrnm, 100, 100, 5, 5, 5, 5, 100)
    elif rc == "loli":
        fill_rc_stats(usrnm, 80, 150, 1, 6, 6, 8, 150)
    elif rc == "mlok":
        fill_rc_stats(usrnm, 50, 150, 5, 7, 3, 8, 100)
    elif rc == "skeli":
        fill_rc_stats(usrnm, 150, 80, 8, 1, 8, 1, 50)

    if clss == "soldier":




create_character('aki', 'loli', 'sniper')