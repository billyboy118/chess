# frozen_string_literal: false

# class which create queen pieces to put on the board
class Queen < Pieces
  def initialize(name, colour)
    super(name, colour)
    @piece_name = 'Queen'
    @piece = get_piece(piece_name, @colour)
    @moves = []
  end
end
