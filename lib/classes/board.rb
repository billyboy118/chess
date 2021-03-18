# frozen_string_literal: false

# this class creates the board with the help of the Squares class
class Board
  def initialize
    @board = []
    create_board(board)
  end

  def create_board(board)
    (0..7).each do |vertical|
      (0..7).each do |horizontal|
        board.push(Square.new([horizontal, vertical]))
      end
    end
  end

end
