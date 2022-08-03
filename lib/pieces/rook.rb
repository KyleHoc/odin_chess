require_relative "spaces_methods"
class Rook
    attr_accessor :color, :name, :position, :coordinate, :valid_spaces, :id
    
    def initialize(number, color, position, coordinate)
        @color = color

        if color == "B"
            icon = "\u2656"
            icon = icon.encode('utf-8')
        else
            icon = "\u265C"
            icon = icon.encode('utf-8')
        end

        @name = "#{icon}#{number}"
        @position = position
        @coordinate = coordinate
        @valid_spaces = []
        @id = "R#{number}"
    end

    def get_valid_spaces(board, color)
        template = [[1,0][2,0],[3,0],[4,0],[5,0],[6,0],[7,0]]
        template2 = [[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7]]
        template3 = [[-1,0][-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0]]
        template4 = [[0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7]]

        one = determine_spaces(template1)
        two = determine_spaces(template2)
        three = determine_spaces(template3)
        four = determine_spaces(template4)

        one = obstruction_finder(one, board, color)
        two = obstruction_finder(two, board, color)
        three = obstruction_finder(three, board, color)
        four = obstruction_finder(four,board, color)

        @valid_spaces = one.concat(two).concat(three).concat(four)
    end
end