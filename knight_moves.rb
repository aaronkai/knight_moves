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
      grid
    else
      piece = nil
      grid
    end
    
  end

  def to_s
    grid.each_with_index do |row, row_index|
      row.each_with_index do |square, index|
        puts "at position #{row_index},#{index} is #{square}" unless square.nil?
      end
    end
  end

  def gather_pieces_for_next_round
    object_array = []
    grid.each do |row|
       row.each do |square|
         square&.each do |knight|
           knight.possible_moves.each do |coords|
             new_path = []
             new_piece = Knight.new(coords)
             new_path << new_piece.path
             if knight.path[0].is_a?(Array)
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
    object_array
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
    [
      [x_coord + 2, y_coord + 1],
      [x_coord + 2, y_coord - 1],
      [x_coord - 2, y_coord + 1],
      [x_coord - 2, y_coord - 1],
      [x_coord + 1, y_coord + 2],
      [x_coord + 1, y_coord - 2],
      [x_coord - 1, y_coord + 2],
      [x_coord - 1, y_coord - 2]
    ]
  end
 
  def to_s
    puts "Location: #{x_coord}, #{y_coord} "
    puts "Path: #{path.inspect}"
  end
end

def knight_moves(start, finish)
  knight = Knight.new([start[0], start[1]])
  board = Board.new
  board.mark_board(knight)

  until board.grid[finish[0]][finish[1]]
    new_pieces = board.gather_pieces_for_next_round
    board = Board.new
    new_pieces.each do |piece|
      board.mark_board(piece)
    end
  end

  answer = []
  board.grid[finish[0]][finish[1]].each do |piece|
    answer.push(piece.path)
  end
  answer
end

p knight_moves([0, 0], [3, 3]).inspect
