# frozen_string_literal: false

# class which create pawn pieces to put on the board
class Pawn < Pieces
  def initialize(name, colour)
    super(name, colour)
    @piece_name = 'Pawn'
    @piece = get_piece(piece_name, @colour)
    @moves = []
    @special_moves = []
    allocate_moves
  end

  def allocate_moves
    if colour == 'White'
      @moves = [[0, 1]]
      @special_moves = [[1, 1], [-1, 1], [0, 2]]
    else
      @moves = [[0, -1]]
      @special_moves = [[1, -1], [-1, 1], [0, -2]]
    end
  end
end
