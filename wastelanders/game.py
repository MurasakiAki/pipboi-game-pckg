from main import read_ini, write_ini

def create_character(usrnm, rc, clss):
    # Stats
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'race', rc)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'class', clss)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'exp', 0)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'level', 1)
 
create_character('aki', 'loli', 'sniper')