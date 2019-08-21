class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end
  
  def mark_board(piece)
    if (piece.x_coord >= 0 && piece.y_coord < 8) && (piece.y_coord >= 0 && piece.y_coord < 8)
      if grid[piece.x_coord][piece.y_coord].nil?
        grid[piece.x_coord][piece.y_coord] = [piece] 
      else 
        grid[piece.x_coord][piece.y_coord].push(piece)
      end
      return grid
    else
      puts "piece off board"
      piece = nil
      return grid
    end
  end
  
  def to_s
    self.grid.each_with_index do |row, row_index|
      row.each_with_index do |square, index|
        puts "at position #{row_index},#{index} is #{square}" unless square.nil?
      end
    end
  end
  
end

class Knight
  attr_accessor :x_coord, :y_coord, :path
  
  def initialize(coords=[0,0])
    @x_coord = coords[0]
    @y_coord = coords[1]
    @path = Path.new([@x_coord, @y_coord])
  end
  
  def possible_moves
   return [
     [x_coord + 2,y_coord + 1],
     [x_coord + 2,y_coord - 1],
     [x_coord - 2,y_coord + 1],
     [x_coord - 2,y_coord - 1],
     [x_coord + 1,y_coord + 2],
     [x_coord + 1,y_coord - 2],
     [x_coord - 1,y_coord + 2],
     [x_coord - 1,y_coord - 2]
   ]
  end  
      
  def to_s
    puts "Location: #{x_coord}, #{y_coord} "
    puts "Path: #{path.path.inspect}"
  end
  
end

class Path
  attr_accessor :path
  
  def initialize(coords)
    @path = [coords[0],coords[1]]
  end
    
  def update(path_array)
    if path_array[1].kind_of?(Array)
      @path = path_array << path 
    else
      self.path = [path_array, path]
    end
  end
  
  def to_s
    puts @path.inspect  
  end
  
end

board = Board.new
knight = Knight.new([0,0])
board.mark_board(knight)

def board_of_forking_paths(board)
  next_rounds_board = Board.new
  board.grid.each do |row|
    row.each do |square|
      unless square.nil?
        square.each do |knight|
          knight.possible_moves.each do |coords|
            branching_knight = Knight.new([coords[0], coords[1]])
            next_rounds_board.mark_board(branching_knight)
            branching_knight.path.update(knight.path.path)
         
          end
        end
      end
    end
  end
  return next_rounds_board
end

puts "ROUND 1"
board = board_of_forking_paths(board)
board.to_s

puts "ROUND 2"
board = board_of_forking_paths(board)


board.to_s






