# frozen_string_literal: false

# some random generic modules to use througout
class Square
  attr_accessor :current_piece
  attr_reader :position

  def initialize(place)
    @position = place
    @current_piece = nil
  end
end
