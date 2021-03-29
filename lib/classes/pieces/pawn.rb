# frozen_string_literal: false

# class which create pawn pieces to put on the board
class Pawn < Pieces
  def initialize(name, colour)
    super(name, colour)
    @piece_name = 'Pawn'
    @piece = get_piece(piece_name, @colour)
    @moves = []
  end

  def allocate_moves
    return @moves = [[0, 2], [0, 1], [1, 1], [-1, 1]] if colour == 'White'

    @moves = [[0, -2], [0, -1], [1, -1], [-1, 1]]
  end

  def calculate_pawn
    allocate_moves
    moves.shift if has_piece_moved == 'Yes'
    can_pawn_take
    calculate_positions
    return true if potential_moves.include?(move_to.position)
  end
end
