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
    case move_index
    when 2, 58
      castling move
    when 6, 62
      castling move
    end
  end
end
