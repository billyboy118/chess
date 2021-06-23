# frozen_string_literal: false

# class which create knight pieces to put on the board
class Knight < Pieces
  def initialize(name, colour, game)
    super(name, colour, game)
    @piece_name = 'Knight'
    @piece = get_piece(piece_name, @colour)
    @moves = [[-1, 2], [1, 2], [2, 1], [2, -1], [-1, -2], [1, -2], [-2, 1], [-2, -1]]
  end
end
