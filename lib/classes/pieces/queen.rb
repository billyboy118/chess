# frozen_string_literal: false

# class which create queen pieces to put on the board
class Queen < Pieces
  def initialize(name, colour, game)
    super(name, colour, game)
    @piece_name = 'Queen'
    @piece = get_piece(piece_name, @colour)
    @moves = [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]]
  end
end
