class Empty
    attr_accessor :name, :position

    def initialize(letter, number)
        @name = "#{letter}#{number}"
    end
end