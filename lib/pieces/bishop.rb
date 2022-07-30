class Bishop
    attr_accessor :color, :name, :position, :coordinate, :valid_spaces
    
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
    end

    def get_valid_spaces
        template = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],
               [-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7],
               [1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7],
               [-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7]]
        temp = []
        @valid_spaces = template
        @valid_spaces.each do |space|
            space[0] = space[0] + @coordinate[0]
            space[1] = space[1] + @coordinate[1]
        end

        @valid_spaces.each do |x|
            temp = temp.append(x.reject {|num| num < 0 || num >= 8})
        end

        @valid_spaces = temp.select {|x|x.length == 2}
    end
end