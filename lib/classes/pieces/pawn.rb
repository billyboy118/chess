# frozen_string_literal: false

# class which create pawn pieces to put on the board
class Pawn
  attr_reader :piece_name, :piece, :player_name, :colour
  attr_accessor :current_location

  include ChessPieces

  def initialize(name, colour)
    @piece_name = 'Pawn'
    @player_name = name
    @colour = colour
    @piece = get_piece(piece_name, @colour)
    @current_location = nil
  end
end
