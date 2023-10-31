from main import read_ini, write_ini

def fill_rc_stats(usrnm, hp, stmn, str, dex, per, agi, spt_dst):
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'health', hp)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'stamina', stmn)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'STR', str)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'DEX', dex)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'PER', per)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'AGI', agi)
    write_ini(f'wastelanders/.{usrnm}.ini','Stats', 'spot_dist', spt_dst)

def fill_clss_stats(usrnm, mn, mss, bckpck, hd, chst, lgs, lft_hnd, rght_hnd):
    write_ini(f'wastelanders/.{usrnm}.ini','INV', 'money', mn)
    write_ini(f'wastelanders/.{usrnm}.ini','INV', 'mass', mss)
    write_ini(f'wastelanders/.{usrnm}.ini','INV', 'backpack', bckpck)
    write_ini(f'wastelanders/.{usrnm}.ini','INV', 'head', hd)
    write_ini(f'wastelanders/.{usrnm}.ini','INV', 'chest', chst)
    write_ini(f'wastelanders/.{usrnm}.ini','INV', 'legs', lgs)
    write_ini(f'wastelanders/.{usrnm}.ini','INV', 'left_hand', lft_hnd)
    write_ini(f'wastelanders/.{usrnm}.ini','INV', 'right_hand', rght_hnd)

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

    bckpck = "I_C_Syringe_50-60_25_6_150_0_F"
    if clss == "soldier":
        fill_clss_stats(usrnm, 100, 20, bckpck, None, "A_CH_OldVest_6-10_15_100_50_5_T", None, "W_M_Dagger_1-6_80_10_200_1_T", "W_G_M9_2-6_5_100_50_1_T")
    elif clss == "gunner":
        fill_clss_stats(usrnm, 100, 20, bckpck, None, "A_CH_Vest_10-12_15_100_100_6_T", None, "W_G_HK419_2-6_5_100_50_5_T", "W_G_HK419_2-6_5_100_50_5_T")
    elif clss == "sniper":
        fill_clss_stats(usrnm, 100, 10, f"{bckpck}|I_T_SmokeBomb_1-2_0_5_200_0_F", None, "A_CH_LightVest_5-8_10_100_45_3_T", None, "W_G_L96_10-20_50_1000_250_8_T", "W_G_L96_10-20_50_1000_250_8_T")
    elif clss == "chemist":
        fill_clss_stats(usrnm, 100, 10, "I_C_Syringe_50-60_25_10_150_0_F", None, "A_CH_LightVest_5-8_10_100_45_3_T", None, "I_T_H2SO4InABottle_10-12_25_25_50_0_T", "W_G_M9_2-6_5_100_50_1_T")
    elif clss == "psycho":
        fill_clss_stats(usrnm, 100, 5, bckpck, None, None, None, None, "W_M_Machette_6-12_60_15_200_2_T")

def init_world(type):
    pass