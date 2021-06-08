# frozen_string_literal: false

# some random generic modules to use througout
module Generic

  LETTERS = { 'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 4, 'F' => 5, 'G' => 6, 'H' => 7 }.freeze
  NUMBERS = { '1' => 0, '2' => 1, '3' => 2, '4' => 3, '5' => 4, '6' => 5, '7' => 6, '8' => 7 }.freeze

  def self.clear
    print "\e[2J\e[f"
  end

  def self.find_square(input, board)
    board.each do |square|
      return square if square.position == input
    end
  end

  def self.find_square_index(input, board)
    board.each_with_index do |square, i|
      return i if square.position == input
    end
  end

  def self.find_index_with_string(value)
    array = []
    array.push(LETTERS[value[0]])
    array.push(NUMBERS[value[3]])
  end
end
