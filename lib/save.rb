require_relative "./board"

class Save_space
  attr_accessor :id, :color, :position, :coordinate

  def new_save(board, current_color)
    File.open("saved_game.txt", 'w') do |file|
    x = 0
      while x < 8 do
        y = 0
        while y < 8 do
          if board[x][y].occupant.id == nil
            file.write "nil"
          else
            file.write board[x][y].occupant.id
          end
          file.write "-"
          if board[x][y].occupant.color == nil
            file.write "nil"
          else
            file.write board[x][y].occupant.color
          end
          file.write "-"
          file.write board[x][y].occupant.position
          file.write "-"
          file.write board[x][y].occupant.coordinate[0]
          file.write board[x][y].occupant.coordinate[1]
          file.write "\n"
          y+=1
        end
        x+=1
      end
      file.write current_color
    end
  end

  def resume()
    data = File.readlines('saved_game.txt')

    board_arr = []
    convert_arr = []

    data.each do |line|
      board_arr.append(line.chomp)
    end
    
    board_arr.each do |space|
      convert_arr.append(space.split('-'))
    end
    convert_arr
  end
end