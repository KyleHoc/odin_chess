require_relative "./space"
require_relative "./pieces/king"
require_relative "./pieces/queen"
require_relative "./pieces/knight"
require_relative "./pieces/rook"
require_relative "./pieces/bishop"
require_relative "./pieces/pawn"
require_relative "./pieces/empty"
require_relative "./save"
class Board
    attr_accessor :spaces, :queen_count, :current_color
    def initialize()
        alpha = ['A', 'B', 'C', 'D', 'E', 'F', "G", 'H']
        @spaces = Array.new(8){Array.new(8)}
        @queen_count = 1
        @current_color = "W"

        x = 0
        while x < 8 do
            y = 0
            while y < 8 do
                empty = Empty.new(alpha[x], y+1, x)
                a_space = Space.new(alpha[x], y+1, empty)
                @spaces[x][y] = a_space
                y+=1
            end
            x+=1
        end
    end

    def print_board
        x = 0
        while x < 8 do
            y = 0
            while y < 8 do
                print " #{@spaces[x][y].occupant.name} "
                y+=1
            end
            puts ""
            x+=1
        end
    end

    def generate_pieces
        kingW = King.new('K', "W", @spaces[7][4].position, [7,4])
        @spaces[7][4].occupant = kingW
        queenW = Queen.new('Q', "W", @spaces[7][3].position, [7,3])
        @spaces[7][3].occupant = queenW
        bishopW1 = Bishop.new('1', "W", @spaces[7][2].position, [7,2])
        @spaces[7][2].occupant = bishopW1
        bishopW2 = Bishop.new('2',"W", @spaces[7][5].position, [7,5])
        @spaces[7][5].occupant = bishopW2
        knightW1 = Knight.new('1', "W", @spaces[7][1].position, [7,1])
        @spaces[7][1].occupant = knightW1
        knightW2 = Knight.new('2', "W", @spaces[7][6].position, [7,6])
        @spaces[7][6].occupant = knightW2
        rookW1 = Rook.new('1', "W", @spaces[7][0].position, [7,0])
        @spaces[7][0].occupant = rookW1
        rookW2 = Rook.new('2', "W", @spaces[7][7].position, [7,7])
        @spaces[7][7].occupant = rookW2

        generate_pawns('W', 6)

        kingB = King.new('K', "B", @spaces[0][4].position, [0,4])
        @spaces[0][4].occupant = kingB
        queenB = Queen.new('Q', "B", @spaces[0][3].position, [0,3])
        @spaces[0][3].occupant = queenB
        bishopB1 = Bishop.new('1', "B", @spaces[0][2].position, [0,2])
        @spaces[0][2].occupant = bishopB1
        bishopB2 = Bishop.new('2',"B", @spaces[0][5].position, [0,5])
        @spaces[0][5].occupant = bishopB2
        knightB1 = Knight.new('1', "B", @spaces[0][1].position, [0,1])
        @spaces[0][1].occupant = knightB1
        knightB2 = Knight.new('2', "B", @spaces[0][6].position, [0,6])
        @spaces[0][6].occupant = knightB2
        rookB1 = Rook.new('1', "B", @spaces[0][0].position, [0,0])
        @spaces[0][0].occupant = rookB1
        rookB2 = Rook.new('2', "B", @spaces[0][7].position, [0,7])
        @spaces[0][7].occupant = rookB2

        generate_pawns('B', 1)
    end

    def generate_pawns(color, y)
        x = 1

        while x < 9
            pawn = Pawn.new(x,color,@spaces[y][x-1].position, [y, x-1])
            @spaces[y][x-1].occupant = pawn
            x+=1
        end
    end

    def make_move(board, color)
        valid_id = get_valid_id(color)
        choose_piece = false
        while choose_piece == false
          puts "Select the piece you'd like to move. Ex. K2 to move Knight 2. King and Queen are just K and Q, or enter 'save' to save your game."
          id = gets.chomp.upcase

          if id == "SAVE"
            save = Save_space.new()
            save.new_save(@spaces, @current_color)
            exit!
          end

          if valid_id.include?(id)
            piece = get_piece(id, color)
            piece.get_valid_spaces(board, color)
            valid_positions = get_positions(piece.valid_spaces)

            pawn_pos = []
            if id.include?("P")
                pawn_pos = pawn_capture(piece.coordinate, color)
                valid_positions = front_occupied(valid_positions, piece.color, piece.coordinate)
            end

            if !pawn_pos.empty?
                valid_positions.append(pawn_pos[0])
                valid_positions.append(pawn_pos[1])
                valid_positions = valid_positions.compact
            end
          end
          
          if valid_id.include?(id) && valid_positions.length != 0
            choose_piece = true
          else
            puts "Invalid piece, or it cannot move. Try again."
          end
        end

        choose_dest = false
        while choose_dest == false
            puts "Choose a valid space to move this piece (A1-H8)"
            puts "This piece can move to: #{valid_positions}"
            destination = gets.chomp.upcase

            if valid_positions.include?(destination)
                choose_dest = true
            else
                puts "Invalid location. Enter a space that is on the board and is not occupied by one of your pieces or in the way of another piece"
            end
        end

        assign_location(piece, destination, self)
        
        if piece.id.include?("P") && (destination.include?("A") || destination.include?("H"))
            @queen_count+=1
            promotion(destination, piece.coordinate, piece.color, @queen_count)
            valid_id.append("Q#{@queen_count}")
        end

        check?(valid_id, color)

        if @current_color == "W"
          @current_color = "B"
        else
          @current_color = "W"
        end
    end

    def get_piece(id, color)
        x = 0
        piece = nil
        while x < 8 do
            y = 0
            while y < 8 do
                if id == @spaces[x][y].occupant.id && color == @spaces[x][y].occupant.color
                    piece = @spaces[x][y].occupant
                end
                y+=1
            end
            x+=1
        end
        piece
    end

    def assign_location(piece, destination, board)
        alpha = ['A', 'B', 'C', 'D', 'E', 'F', "G", 'H']
        x = 0
        while x < 8 do
            y = 0
            while y < 8 do
                if @spaces[x][y].occupant.position == piece.position
                    @spaces[x][y].occupant = Empty.new(alpha[x],y+1, x)
                end

                if @spaces[x][y].occupant.position == destination
                    piece.position = destination
                    piece.coordinate = [x,y]
                    @spaces[x][y].occupant = piece
                    @spaces[x][y].occupant.get_valid_spaces(board, board.spaces[x][y].occupant.color)
                end
                y+=1
            end
            x+=1
        end
    end

    def get_positions(valid_spaces)
        valid_positions = []
        valid_spaces.each do |space|
            x = 0
            while x < 8 do
                y = 0
                while y < 8 do
                    if @spaces[x][y].occupant.coordinate == space
                        valid_positions.append(@spaces[x][y].occupant.position)
                    end
                    y+=1
                end
                x+=1
            end
        end
        valid_positions
    end

    def checkmate(color)
        king_present = get_piece('K', color)
        winner = []

        if king_present == nil
            winner.append(true)
            winner.append(color)
        else
            winner.append(false)
        end
        winner
    end

    def pawn_capture(coordinate, color)
      x = coordinate[0]
      y = coordinate[1]
      positions = []
      if color == "W"
        if x > 0 && y > 0
          if !@spaces[x-1][y-1].occupant.is_a?(Empty)
            if @spaces[x-1][y-1].occupant.color == "B"
              positions.append(@spaces[x-1][y-1].position)
            end
          end
        end
        if x > 0 && y < 7
          if !@spaces[x-1][y+1].occupant.is_a?(Empty)
            if @spaces[x-1][y+1].occupant.color == "B"
              positions.append(@spaces[x-1][y+1].position)
            end
          end
        end
      end

      if color == "B"
        if x < 7 && y > 0
          if !@spaces[x+1][y-1].occupant.is_a?(Empty)
            if @spaces[x+1][y-1].occupant.color == "W"
              positions.append(@spaces[x+1][y-1].position)
            end
          end
        end
        if x < 7 && y < 7
          if !@spaces[x+1][y+1].occupant.is_a?(Empty)
            if @spaces[x+1][y+1].occupant.color == "W"
              positions.append(@spaces[x+1][y+1].position)
            end
          end
        end
      end
      positions
    end

    def promotion(destination, coordinate, color, count)
        x = 0
        while x < 8 do
            y = 0
            while y < 8 do
                if @spaces[x][y].position == destination
                    @spaces[x][y].occupant = Queen.new("Q#{count}", color, @spaces[x][y].position, coordinate)
                    @spaces[x][y].occupant.id = "Q#{count}"
                end
                y+=1  
            end
            x+=1
        end
    end

    def front_occupied(positions, color, coordinate)
      x = coordinate[0]
      y = coordinate[1]
      positions.each do |pos|
        if color == "W"
          if (pos == @spaces[x-1][y].position) && !@spaces[x-1][y].occupant.is_a?(Empty)
            positions.delete(pos)
          end
          if (pos == @spaces[x-2][y].position) && !@spaces[x-2][y].occupant.is_a?(Empty)
            positions.delete(pos)
          end
        end

        if color == "B"
          if pos == @spaces[x+1][y].position && !@spaces[x+1][y].occupant.is_a?(Empty)
            positions.delete(pos)
          end
          if pos == @spaces[x+2][y].position && !@spaces[x+2][y].occupant.is_a?(Empty)
            positions.delete(pos)
          end
        end
      end
    end

    def get_valid_id(color)
        valid_id = []
        x = 0
        while x < 8 do
            y = 0
            while y < 8 do
                if !@spaces[x][y].occupant.is_a?(Empty)
                  if @spaces[x][y].occupant.color == color
                    valid_id.append(@spaces[x][y].occupant.id)
                  end
                end
                y+=1
            end
            x+=1
        end
        valid_id
    end

    def check?(valid_id, color)
      if color == "W"
        other_color = 'B'
      else
        other_color = "W"
      end

      king = get_piece('K', other_color)
      if king == nil
        return
      end
      coord = king.coordinate

      valid_id.each do |piece|
        a_piece = get_piece(piece, color)
        a_piece.get_valid_spaces(self, color)
        
        if a_piece.valid_spaces.include?(king.coordinate)
          @spaces[coord[0]][coord[1]].occupant.check = true
            puts""
            if color == "W"
              puts "Black is in check"
              break
            else
              puts "White is in check"
              break
            end
        else
            @spaces[coord[0]][coord[1]].occupant.check = false
        end
      end
    end

    def assign_resume(space)
      x = space[3].split('')[0].to_i
      y = space[3].split('')[1].to_i
      position = space[2]

      if space[0] != 'nil'
        number = space[0].split('')
        color = space[1]
      end

      if space[0].include?("R")
        rook = Rook.new(number[1], color, position, [x,y])
        @spaces[x][y].occupant = rook
      elsif space[0] == 'K'
        king = King.new(number[0], color, position, [x,y])
        @spaces[x][y].occupant = king
      elsif space[0].include?('K')
        knight = Knight.new(number[1], color, position, [x,y])
        @spaces[x][y].occupant = knight
      elsif space[0] == 'Q'
        queen = Queen.new(number[0], color, position, [x,y])
        @spaces[x][y].occupant = queen
      elsif space[0].include?('B')
        bishop = Bishop.new(number[1], color, position, [x,y])
        @spaces[x][y].occupant = bishop
      elsif space[0].include?('P')
        pawn = Pawn.new(number[1], color, position, [x,y])
        @spaces[x][y].occupant = pawn
      else
        empty = Empty.new(position.split('')[0], position.split('')[1].to_i, x)
        @spaces[x][y].occupant = empty
      end
    end
  end