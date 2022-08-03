require_relative "spaces_methods"
class Pawn
    attr_accessor :color, :name, :position, :coordinate, :valid_spaces, :id
    
    def initialize(number, color, position, coordinate)
        @color = color

        if color == "B"
            icon = "\u2659"
            icon = icon.encode('utf-8')
        else
            icon = "\u265F"
            icon = icon.encode('utf-8')
        end

        @name = "#{icon}#{number}"
        @position = position
        @coordinate = coordinate
        @valid_spaces = []
        @id = "P#{number}"
    end

    def get_valid_spaces(board, color)
        if color == 'B'
          template = [[1,0],[2,0]]
        else
          template = [[-1,0],[-2,0]]
        end

        @valid_spaces = determine_spaces(template)
        @valid_spaces = remove_occupied(@valid_spaces, board, color)

        if self.coordinate[0] != 6
            @valid_spaces.pop
        end
    end
end