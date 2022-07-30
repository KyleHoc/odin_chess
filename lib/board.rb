require "./space"
require "./pieces/king"
require "./pieces/queen"
require "./pieces/knight"
require "./pieces/rook"
require "./pieces/bishop"
require "./pieces/pawn"
require "./empty"
class Board
    attr_accessor :spaces
    def initialize()
        alpha = ['A', 'B', 'C', 'D', 'E', 'F', "G", 'H']
        @spaces = Array.new(8){Array.new(8)}

        x = 0
        while x < 8 do
            y = 0
            while y < 8 do
                empty = Empty.new(alpha[x], y+1)
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
            pawn = Pawn.new(x,color,@spaces[x-1][y].position, [x-1,y])
            @spaces[y][x-1].occupant = pawn
            x+=1
        end
    end
end

my_board = Board.new()
my_board.generate_pieces
my_board.print_board
my_board.spaces[7][2].occupant.get_valid_spaces
p my_board.spaces[7][2].occupant