# frozen_string_literal: false

# class which create king pieces to put on the board
class King < Pieces
  CASTLING_MOVES = [2, 58, 6, 62].freeze
  def initialize(name, colour)
    super(name, colour)
    @piece_name = 'King'
    @piece = get_piece(piece_name, @colour)
    @moves = [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]]
    @special_moves = []
  end

  def calculate_king
    calculate_positions
    castling # return true if castlig == true # hide this so i can move the king anywhere
    return true if potential_moves.include?(move_to.position)

    false # to move king anywhere I can change this to a true
  end

  def castling
    return if no_of_moves.positive?

    # return if check == true
    move_index = Generic.find_square_index(move_to.position, board)
    return if check_colour(move_index) == false

    case move_index
    when 2, 58
      castling_move_left(move_index)
    when 6, 62
      castling_move_right(move_index)
    end
  end

  def check_colour(move_index)
    sum = colour == 'White' ? 4 : 60
    sum -= move_index
    sum = sum.abs
    puts sum
    return true if sum == 2

    false
  end

  def castling_move_left(move_index)

  end

  def castling_move_right(move_index)

  end
end
