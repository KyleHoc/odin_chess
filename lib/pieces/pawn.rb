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

        if self.coordinate[0] != 6 || self.coordinate[0] != 1
            @valid_spaces.pop
        end
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

#next order of business: pawn's capture method needs to be added. Need a function to add a valid space if an opposing piece is diagonal to it
#then promotion and castling can be added