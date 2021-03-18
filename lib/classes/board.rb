# frozen_string_literal: false

# this class creates the board with the help of the Squares class
class Board
  def initialize(player1, player2 = nil)
    @board = []
    @player1 = player1
    @player2 = player2
    create_board
  end

  def create_board
    (0..7).each do |vertical|
      (0..7).each do |horizontal|
        @board.push(Square.new([horizontal, vertical]))
      end
    end
    puts @board[1].position
  end

end
