def is_valid_coord(coord_str):
    parts = coord_str.split('-')

    if len(parts) != 2:
        return False

    try:
        x, y = map(int, parts)

        if 0 <= x <= 2 and 0 <= y <= 2:
            return True
    except ValueError:
        pass

    return False

def start():
    #while True:
        has_ended = False
        turn = 0
        board = [
            ["[ ]", "[ ]", "[ ]"],
            ["[ ]", "[ ]", "[ ]"],
            ["[ ]", "[ ]", "[ ]"]
        ]

        while not has_ended:
            print('|-----------|')
            for row in range(len(board)):
                print(f"|{board[row][0]}|{board[row][1]}|{board[row][2]}|")
            print('|-----------|')

            coord = None
            if turn%2 == 0:
                while not is_valid_coord(coord): 
                    coord = input("Player X [x-y]:\n")
                    has_ended = True
            else:
                while not is_valid_coord(coord): 
                    coord = input("Player O [x-y]:\n")
                    has_ended = True                
    

start()