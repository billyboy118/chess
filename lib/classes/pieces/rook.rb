# frozen_string_literal: false

# class which create rook pieces to put on the board
class Rook < Pieces
  def initialize(name, colour)
    super(name, colour)
    @piece_name = 'Rook'
    @piece = get_piece(piece_name, @colour)
    @moves = [[0, 1], [-1, 0], [1, 0], [0, -1]]
  end
end
