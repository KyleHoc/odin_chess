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

    def determine_spaces(template)
        temp = []
        valid_array = template
        valid_array.each do |space|
            space[0] = space[0] + @coordinate[0]
            space[1] = space[1] + @coordinate[1]
        end
    
        valid_array.each do |x|
            temp = temp.append(x.reject {|num| num < 0 || num >= 8})
        end
    
        valid_array = temp.select {|x|x.length == 2}
        valid_array
    end
end