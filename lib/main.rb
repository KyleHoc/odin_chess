require_relative "./board"
require_relative "./save"
def play_game(board)
  board.generate_pieces
  resume_game(board)
  board.print_board
  
  if board.current_color == "W"
    other_color = "B"
    other = "Black"
    current = "White"
  else
    other_color = "W"
    other = "White"
    current = "Black"
  end

  puts "#{current} goes first"

  checkmate = [false]
  until checkmate[0]
    puts "It's #{current}'s move"
    board.make_move(board, board.current_color)
    board.print_board
    checkmate = board.checkmate(other_color)

    if !checkmate[0]
      puts "Now it's #{other}'s move"
      board.make_move(board, "#{other_color}")
      board.print_board
      checkmate = board.checkmate(board.current_color)
    end
  end
  print_winner(checkmate)
end

def print_winner(checkmate)
  if checkmate[1] == 'B'
    puts "Checkmate! White wins!"
  else
    puts "Checkmate! Black wins!"
  end
end

def resume_game(board)
  puts "Would you like to resume your previous game? (Type 'y' for yes, otherwise no)"
  save = Save_space.new()
  answer = gets.chomp.upcase

  if answer == 'Y'
    saved_board = save.resume()
    z = 0
    x = 0
      while x < 8 do
        y = 0
          while y < 8 do
            board.assign_resume(saved_board[z])
            y+=1
            z+=1
          end
          x+=1
      end
      board.current_color = saved_board[-1][0]
      puts board.current_color
  end
end

my_board = Board.new()
play_game(my_board)