# frozen_string_literal: false

# class which create knight pieces to put on the board
class Knight < Pieces
  def initialize(name, colour)
    super(name, colour)
    @piece_name = 'Knight'
    @piece = get_piece(piece_name, @colour)
    @moves = []
  end
end
