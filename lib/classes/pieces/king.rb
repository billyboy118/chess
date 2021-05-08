# frozen_string_literal: false

# class which create king pieces to put on the board
class King < Pieces
  def initialize(name, colour)
    super(name, colour)
    @piece_name = 'King'
    @piece = get_piece(piece_name, @colour)
    @moves = [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]]
    @special_moves = []
  end

  def calculate_king
    calculate_positions
    return true if potential_moves.include?(move_to.position)

    false # to move king anywhere I can change this to a true
  end
end
