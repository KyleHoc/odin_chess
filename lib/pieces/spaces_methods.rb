require_relative "empty"

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