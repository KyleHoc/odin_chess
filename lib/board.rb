require "./space"
require "./pieces/king"
require "./pieces/queen"
require "./pieces/knight"
require "./pieces/rook"
require "./pieces/bishop"
require "./pieces/pawn"
require_relative "./pieces/empty"
class Board
    attr_accessor :spaces
    def initialize()
        alpha = ['A', 'B', 'C', 'D', 'E', 'F', "G", 'H']
        @spaces = Array.new(8){Array.new(8)}

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
        choose_piece = false
        while choose_piece == false
          valid_id = ['P1', 'P2', 'P3', 'P4', 'P5', 'P6', 'P7', 'P8', 'B1', 'B2', 'K1', 'K2', 'R1', 'R2', 'K', 'Q']
          puts "Select the piece you'd like to move. Ex. K2 to move Knight 2. King and Queen are just K and Q respectively."
          id = gets.chomp.upcase
          
          if valid_id.include?(id)
            choose_piece = true
          else
            puts "Invalid piece. Try again."
          end
        end

        piece = get_piece(id)
        piece.get_valid_spaces(board, color)
        valid_positions = get_positions(piece.valid_spaces)

        choose_dest = false
        while choose_dest == false
            puts "Choose a valid space to move this piece (A1-H8)"
            destination = gets.chomp.upcase

            if valid_positions.include?(destination)
                choose_dest = true
            else
                puts "Invalid location. Enter a space that is on the board and is not occupied by one of your pieces or in the way of another piece"
            end
        end

        assign_location(piece, destination, self)
    end

    def get_piece(id)
        x = 0
        while x < 8 do
            y = 0
            while y < 8 do
                if id == @spaces[x][y].occupant.id
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

    def valid_starting_spaces(board)
        y = 0
        while y < 8
            board.spaces[0][y].occupant.get_valid_spaces(my_board, my_board.spaces[0][y].occupant.color)
        end
        y = 0
        while y < 8
            board.spaces[1][y].occupant.get_valid_spaces(my_board, my_board.spaces[1][y].occupant.color)
        end
        y = 0
        while y < 8
            board.spaces[6][y].occupant.get_valid_spaces(my_board, my_board.spaces[6][y].occupant.color)
        end
        y = 0
        while y < 8
            board.spaces[7][y].occupant.get_valid_spaces(my_board, my_board.spaces[7][y].occupant.color)
        end
    end

    def get_positions(valid_spaces)
        valid_positions = []
        x = 0
        valid_spaces.each do |space|
            while x < 8 do
                y = 0
                while y < 8 do
                    meh = @spaces[x][y]
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
end

my_board = Board.new()
my_board.generate_pieces
my_board.print_board
my_board.spaces[6][3].occupant.get_valid_spaces(my_board, my_board.spaces[6][3].occupant.color)
p my_board.spaces[6][3].occupant
my_board.make_move(my_board, "W")
#my_board.assign_location(my_board.spaces[6][3].occupant, "F4", my_board)
my_board.print_board
#my_board.spaces[5][3].occupant.get_valid_spaces(my_board, my_board.spaces[5][3].occupant.color)
#p my_board.spaces[5][3].occupant
#p my_board.spaces[6][3].occupant