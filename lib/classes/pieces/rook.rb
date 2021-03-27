# frozen_string_literal: false

# class which create rook pieces to put on the board
class Rook < Pieces
  def initialize(name, colour)
    super(name, colour)
    @piece_name = 'Rook'
    @piece = get_piece(piece_name, @colour)
    @moves = []
  end
end
