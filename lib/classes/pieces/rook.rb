# frozen_string_literal: false

# class which create rook pieces to put on the board
class Rook
  attr_reader :piece_name, :piece, :colour
  attr_accessor :current_location

  include ChessPieces

  def initialize(name, colour)
    @piece_name = 'Rook'
    @player_name = name
    @colour = colour
    @piece = get_piece(piece_name, @colour)
    @current_location = nil
  end
end
