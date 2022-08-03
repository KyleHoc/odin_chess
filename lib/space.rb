class Space
    attr_accessor :position, :occupant
    def initialize(letter, number, occupant)
        @position = "#{letter}#{number}"
        @occupant = occupant
    end

    def position
        @position
    end
end