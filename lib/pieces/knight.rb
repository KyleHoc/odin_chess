require_relative "spaces_methods"
# coding: UTF-8
class Knight
    attr_accessor :color, :name, :position, :coordinate, :valid_spaces, :id
    
    def initialize(number, color, position, coordinate)
        @color = color

        if color == "B"
            icon = "\u2658"
            icon = icon.encode('utf-8')
        else
            icon = "\u265E"
            icon = icon.encode('utf-8')
        end

        @name = "#{icon}#{number}"
        @position = position
        @coordinate = coordinate
        @valid_spaces = []
        @id = "K#{number}"
    end

    def get_valid_spaces(board, color)
        template = [[2,1],[2,-1],[1,2],[1,-2],[-2,1],[-2,-1],[-1,2],[-1,-2]]
        @valid_spaces = determine_spaces(template)
        @valid_spaces = remove_occupied(@valid_spaces, board, color)
    end
end