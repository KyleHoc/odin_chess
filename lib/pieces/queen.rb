require_relative "spaces_methods"
class Queen
    attr_accessor :color, :name, :position, :coordinate, :valid_spaces, :id

    def initialize(number, color, position, coordinate)
        @color = color

        if color == "B"
            icon = "\u2655"
            icon = icon.encode('utf-8')
        else
            icon = "\u265B"
            icon = icon.encode('utf-8')
        end

        @name = "#{icon}#{number}"
        @position = position
        @coordinate = coordinate
        @valid_spaces = []
        @id = "Q"
    end

    def get_valid_spaces(board, color)
        template = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]
        template2 = [[-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7]]
        template3 = [[1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7]]
        template4 = [[-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7]]
        template5 = [[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0]]
        template6 = [[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7]]
        template7 = [[-1,0],[-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0]]
        template8 = [[0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7]]

        one = determine_spaces(template1)
        two = determine_spaces(template2)
        three = determine_spaces(template3)
        four = determine_spaces(template4)
        five = determine_spaces(template5)
        six = determine_spaces(template6)
        seven = determine_spaces(template7)
        eight = determine_spaces(template8)

        one = obstruction_finder(one, board, color)
        two = obstruction_finder(two, board, color)
        three = obstruction_finder(three, board, color)
        four = obstruction_finder(four, board, color)
        five = obstruction_finder(five, board, color)
        six = obstruction_finder(six, board, color)
        seven = obstruction_finder(seven, board, color)
        eight = obstruction_finder(eight, board, color)

        @valid_spaces = one.concat(two).concat(three).concat(four).concat(five).concat(six).concat(seven).concat(eight)
    end
end