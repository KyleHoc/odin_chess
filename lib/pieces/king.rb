require_relative "spaces_methods"
class King
    attr_accessor :color, :name, :position, :valid_spaces, :id, :coordinate
    
    def initialize(number, color, position, coordinate)
        @color = color

        if color == "B"
            icon = "\u2654"
            icon = icon.encode('utf-8')
        else
            icon = "\u265A"
            icon = icon.encode('utf-8')
        end

        @name = "#{icon}#{number}"
        @position = position
        @coordinate = coordinate
        @valid_spaces = []
        @id = "K"
    end

    def get_valid_spaces(board, color)
        template = [[0,1],[0,-1],[1,0],[-1,0],[1,1],[-1,-1],[1,-1],[-1,1]]
        @valid_spaces = determine_spaces(template)
        @valid_spaces = remove_occupied(@valid_spaces, board, color)
    end
end

#determine spaces works, but remove occupied isn't doing anything