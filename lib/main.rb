require_relative "./board"

def play_game(board)
    my_board.generate_pieces
    my_board.print_board
    my_board.valid_starting_spaces(my_board)
    puts "White goes first"
    
end

my_board = Board.new()
play_game(my_board)