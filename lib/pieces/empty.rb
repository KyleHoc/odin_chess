class Empty
    attr_accessor :name, :position, :valid_spaces, :id, :coordinate, :color

    def initialize(letter, number, x)
        @name = "#{letter}#{number}"
        @position = "#{letter}#{number}"
        @valid_spaces = []
        @id = nil
        @coordinate = [x, number-1]
        @color = nil
    end
end