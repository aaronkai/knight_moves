class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end
  
  def mark_board(piece)
    if (piece.x_coord >= 0 && piece.x_coord < 8) && (piece.y_coord >= 0 && piece.y_coord < 8)
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
  
  def gather_pieces_for_next_round
    object_array = []
    self.grid.each do |row|
       row.each do |square|
         unless square.nil? 
           square.each do |knight|
            knight.possible_moves.each do |coords|
              new_path = []
              new_piece = Knight.new(coords)
              new_path << new_piece.path
              if knight.path[0].kind_of?(Array)
                knight.path.each do |path|
                  new_path = new_path << path
                end
              else
                new_path = new_path << knight.path
              end
              new_piece.path = new_path
              object_array.push(new_piece)
            end
          end
         end
       end
    end
    return object_array
  end
  
end

class Knight
  attr_accessor :x_coord, :y_coord, :path
  
  def initialize(coords=[0,0])
    @x_coord = coords[0]
    @y_coord = coords[1]
    @path = [@x_coord, y_coord]
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
    puts "Path: #{path.inspect}"
  end
  
end

###Lets start over
new_knight = Knight.new([4,4])
new_board = Board.new
new_board.mark_board(new_knight)
new_pieces = new_board.gather_pieces_for_next_round

new_board2 = Board.new
new_pieces.each do |piece|
  new_board2.mark_board(piece)
end
p new_board2

new_pieces = new_board2.gather_pieces_for_next_round
new_board3 = Board.new
new_pieces.each_with_index do |piece, index|
  new_board3.mark_board(piece)
  #puts "#{index}: #{piece}"
end
p new_board3

# ###This works
# board = Board.new
# knight = Knight.new([0,0])
# board.mark_board(knight)
# knight.path.update([3,3])
# puts knight
# knight.path.update([4,4])
# puts knight
# knight2 = Knight.new([5,5])
# knight2.path.update(knight.path.path)
# puts knight2

# class Path
#   attr_accessor :path
  
#   def initialize(coords)
#     @path = [coords[0],coords[1]]
#   end
    
#   def update(piece)
#     path_array = piece.path.path
#     if path_array[1].kind_of?(Array)
#       self.path = path_array << @path  
#     else
#       self.path = [[path_array], [@path] ] 
#     end
#   end
  
#   def to_s
#     puts @path.inspect  
#   end
  
# end