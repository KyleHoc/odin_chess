require_relative "empty"
#def determine_spaces(template)
    #temp = []
    #valid_array = template
    #valid_array.each do |space|
     #   space[0] = space[0] + @coordinate[0]
      #  space[1] = space[1] + @coordinate[1]
    #end

    #valid_array.each do |x|
     #   temp = temp.append(x.reject {|num| num < 0 || num >= 8})
    #end

    #valid_array = temp.select {|x|x.length == 2}
    #valid_array
#end

def obstruction_finder(valid_array, board, color)
    obstruction_found = false
    valid_array.each_with_index do |space, index|
        if !obstruction_found
            x = space[0]
            y = space[1]

            if !board.spaces[x][y].occupant.is_a?(Empty)
                obstruction_found = true
                if board.spaces[x][y].occupant.color == color
                    valid_array[index] = nil
                end
            end
        else
            valid_array[index] = nil
        end
    end
    valid_array.compact
end

def remove_occupied(valid_array, board, color)
    valid_array.each_with_index do |space, index|
        x = space[0]
        y = space[1]
        
        if !board.spaces[x][y].occupant.is_a?(Empty) && (board.spaces[x][y].occupant.color == color)
            valid_array[index] = nil
        end
    end
    valid_array.compact
end