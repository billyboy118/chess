# frozen_string_literal: false

# class which create knight pieces to put on the board
class Knight
  attr_reader :piece_name, :piece, :colour
  attr_accessor :current_location

  include ChessPieces

  def initialize(name, colour)
    @piece_name = 'Knight'
    @player_name = name
    @colour = colour
    @piece = get_piece(piece_name, @colour)
    @current_location = nil
  end
end
