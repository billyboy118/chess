# frozen_string_literal: false

# class which create pawn pieces to put on the board
class Pawn < Pieces
  def initialize(name, colour)
    super(name, colour)
    @piece_name = 'Pawn'
    @piece = get_piece(piece_name, @colour)
    @moves = [0, 1]
  end
end
