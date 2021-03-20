# frozen_string_literal: false

# class which create players
class Player
  attr_reader :name, :colour, :winner

  def initialize(name, colour)
    @name = name
    @colour = colour
    @winner = nil
  end
end
