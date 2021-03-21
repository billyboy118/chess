# frozen_string_literal: false

# class which create players
class Player
  attr_reader :name, :colour, :winner
  attr_accessor :selected_piece, :selected_move, :selected_grid

  def initialize(name, colour)
    @name = name
    @colour = colour
    @winner = nil
    @selected_grid = nil
    @selected_piece = nil
    @selected_move = nil
  end
end
