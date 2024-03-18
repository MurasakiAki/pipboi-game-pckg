PLAYER_FILE_DIR = "wastelanders/characters/"

def read_ini(file, section, var, type):
    config = configparser.ConfigParser()
    config.read(file)

    if type == "s":
        return config.get(section, var)
    elif type == "i":
        return config.getint(section, var)
    else:
        print("Wrong type")

def write_ini(file, section, var, input):
    config = configparser.ConfigParser()
    config.read(file)

    if section not in config:
        config[section] = {}

    config[section][var] = str(input)

    with open(file, 'w') as configfile:
        config.write(configfile)


class Player():
    def __init__(self, usrnm, rc, clss):
        self.usrnm = usrnm
        self.rc = rc
        self.clss = clss
        self.hp = 0
        self.stmn = 0
        self.STR = 0 # increases large weapons, health
        self.DEX = 0 # increases small weapons
        self.PER = 0 # increases guns
        self.AGI = 0 # determines successful evade, number of actions per turn(stamina)
        self.weapon = {}
        self.backpack = {}
        self.money = 0
        self.fill_rc_stats()
        
    @property
    def hp(self):
        return self._hp

    @property
    def stmn(self):
        return self._stmn

    @property
    def STR(self):
        return self._STR

    @property
    def DEX(self):
        return self._DEX

    @property
    def PER(self):
        return self._PER

    @property
    def AGI(self):
        return self._AGI

    def set_hp(self, hp):
        self._hp = hp

    def set_stmn(self, stmn):
        self._stmn = stmn

    def set_STR(self, STR):
        self._STR = STR

    def set_DEX(self, DEX):
        self._DEX = DEX

    def set_PER(self, PER):
        self._PER = PER

    def set_AGI(self, AGI):
        self._AGI = AGI

    def fill_rc_stats(self):
        if rc == "human":
            self.set_hp(100)
            self.set_stmn(100)
            self.set_STR(6)
            self.set_DEX(5)
            self.set_PER(5)
            self.set_AGI(5)
        elif rc == "loli":
            self.set_hp(80)
            self.set_stmn(150)
            self.set_STR(1)
            self.set_DEX(6)
            self.set_PER(6)
            self.set_AGI(8)
        elif rc == "mlok":
            self.set_hp(50)
            self.set_stmn(150)
            self.set_STR(5)
            self.set_DEX(7)
            self.set_PER(3)
            self.set_AGI(8)
        elif rc == "skeli":
            self.set_hp(150)
            self.set_stmn(80)
            self.set_STR(8)
            self.set_DEX(1)
            self.set_PER(8)
            self.set_AGI(1)

    
    def fill_clss_stats(self, bckpck):
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

    bckpck = "U_H_Syringe_(50-60)_(5)"
    if clss == "soldier":
        fill_clss_stats(usrnm, 100, f"{bckpck}|W_M_L_BroadSword_(12-16)_(1)")
    elif clss == "gunner":
        fill_clss_stats(usrnm, 80, f"{bckpck}|W_G_L_AK15_(5-9)_(15)_(45)")
    elif clss == "sniper":
        fill_clss_stats(usrnm, 50, f"{bckpck}|W_G_L_GaussRifle_(40-55)_(1)_(50)|U_T_SmokeBomb_(5-20)_(1-4)_(5)")
    elif clss == "chemist":
        fill_clss_stats(usrnm, 200, f"{bckpck}|")
    elif clss == "psycho":
        fill_clss_stats(usrnm, 0, bckpck)

def init_world(type):
    pass
