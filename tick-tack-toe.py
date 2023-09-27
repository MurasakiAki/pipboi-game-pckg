def win_check(board, turn):
    for row in board:
        if row[0] == "[X]" and row[1] == "[X]" and row[2] == "[X]":
            print(f"Player X won in {turn} turns!")
            return True
        if row[0] == "[O]" and row[1] == "[O]" and row[2] == "[O]":
            print(f"Player O won in {turn} turns!")
            return True

    for i in range(3):
        # Check columns for wins
        if board[0][i] == "[X]" and board[1][i] == "[X]" and board[2][i] == "[X]":
            print(f"Player X won in {turn} turns!")
            return True
        if board[0][i] == "[O]" and board[1][i] == "[O]" and board[2][i] == "[O]":
            print(f"Player O won in {turn} turns!")
            return True

    # Add checks for diagonal wins as well
    if board[0][0] == "[X]" and board[1][1] == "[X]" and board[2][2] == "[X]":
        print(f"Player X won in {turn} turns!")
        return True
    if board[0][2] == "[X]" and board[1][1] == "[X]" and board[2][0] == "[X]":
        print(f"Player X won in {turn} turns!")
        return True
    if board[0][0] == "[O]" and board[1][1] == "[O]" and board[2][2] == "[O]":
        print(f"Player O won in {turn} turns!")
        return True
    if board[0][2] == "[O]" and board[1][1] == "[O]" and board[2][0] == "[O]":
        print(f"Player O won in {turn} turns!")
        return True

    return False

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
        coord = ""

        if turn % 2 == 0:
            while not is_valid_coord(coord):
                coord = input("Player X [x-y]:\n")
            x = int(coord[0])
            y = int(coord[2])
            if board[y][x] == "[ ]":
                board[y][x] = "[X]"
                turn += 1
        else:
            while not is_valid_coord(coord):
                coord = input("Player O [x-y]:\n")
            x = int(coord[0])
            y = int(coord[2])
            if board[y][x] == "[ ]":
                board[y][x] = "[O]"
                turn += 1

        # Check for a win after each move
        if win_check(board, turn):
            has_ended = True

    # After the game ends, print the final board state
    print('|-----------|')
    for row in range(len(board)):
        print(f"|{board[row][0]}|{board[row][1]}|{board[row][2]}|")
    print('|-----------|')

# Call the start function to begin the game
start()
