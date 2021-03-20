# frozen_string_literal: false

# class which create players
class Player
  attr_reader :name, :colour

  def initialize(name, colour)
    @name = name
    @colour = colour
  end
end
