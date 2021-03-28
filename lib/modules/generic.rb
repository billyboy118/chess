# frozen_string_literal: false

# some random generic modules to use througout
module Generic
  def self.clear
    print "\e[2J\e[f"
  end

  def self.find_square(input, board)
    board.each do |square|
      return square if square.position == input
    end
  end
end
