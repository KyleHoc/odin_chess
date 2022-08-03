require_relative "spaces_methods"
class Bishop
    attr_accessor :color, :name, :position, :coordinate, :valid_spaces, :id
    
    def initialize(number, color, position, coordinate)
        @color = color

        if color == "B"
            icon = "\u2657"
            icon = icon.encode('utf-8')
        else
            icon = "\u265D"
            icon = icon.encode('utf-8')
        end

        @name = "#{icon}#{number}"
        @position = position
        @coordinate = coordinate
        @valid_spaces = []
        @id = "B#{number}"
    end

    def get_valid_spaces(board, color)
        template1 = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]
        template2 = [[-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7]]
        template3 = [[1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7]]
        template4 = [[-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7]]
        
        one = determine_spaces(template1)
        two = determine_spaces(template2)
        three = determine_spaces(template3)
        four = determine_spaces(template4)

        one = obstruction_finder(one, board, color)
        two = obstruction_finder(two, board, color)
        three = obstruction_finder(three, board, color)
        four = obstruction_finder(four, board, color)

        @valid_spaces = one.concat(two).concat(three).concat(four)
    end
end