# frozen_string_literal: false

# super class for all chess pieces to inherit from
class Pieces
  attr_reader :piece_name, :piece, :player_name, :colour
  attr_accessor :current_location

  include ChessPieces

  def initialize(name, colour)
    @player_name = name
    @colour = colour
    @piece = get_piece(piece_name, @colour)
    @current_location = nil
  end
end
