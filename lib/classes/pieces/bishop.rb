# frozen_string_literal: false

# class which create bishop pieces to put on the board
class Bishop < Pieces
  def initialize(name, colour, game)
    super(name, colour, game)
    @piece_name = 'Bishop'
    @piece = get_piece(piece_name, @colour)
    @moves = [[-1, 1], [1, 1], [-1, -1], [1, -1]]
  end
end
