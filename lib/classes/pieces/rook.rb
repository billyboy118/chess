# frozen_string_literal: false

# class which create rook pieces to put on the board
class Rook
  attr_reader :piece_name, :piece

  include ChessPieces

  def initialize(name, colour)
    @piece_name = 'Rook'
    @player_name = name
    @colour = colour
    @piece = get_piece(piece_name, @colour)
  end
end
