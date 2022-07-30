class Queen
    attr_accessor :color, :name, :position, :coordinate
    template = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]
    template2 = [[-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7]]
    template3 = [[1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7]]
    template4 = [[-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7]]
    template5 = [[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0]]
    template6 = [[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7]]
    template7 = [[-1,0],[-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0]]
    template8 = [[0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7]]
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
    end
end