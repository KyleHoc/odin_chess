require_relative "./board"

def play_game(board)
  board.generate_pieces
  board.print_board
#  board.valid_starting_spaces(board)
  puts "White goes first"

  checkmate = [false]
  until checkmate[0]
    puts "White's move"
    board.make_move(board, "W")
    board.print_board
    checkmate = board.checkmate("B")

    if !checkmate[0]
      puts "Now it's Black's move"
      board.make_move(board, "B")
      board.print_board
      checkmate = board.checkmate("W")
    end
  end
  print_winner(checkmate)
end

def print_winner(checkmate)
  if checkmate[1] == "B"
    puts "Checkmate! White wins!"
  else
    puts "Checkmate! Black wins!"
  end
end

my_board = Board.new()
play_game(my_board)