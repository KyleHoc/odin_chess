class Rook
    attr_accessor :color, :name, :position, :coordinate
    template = [[1,0][2,0],[3,0],[4,0],[5,0],[6,0],[7,0],
                [0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],
                [-1,0][-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0],
                [0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7]]
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
    end
end