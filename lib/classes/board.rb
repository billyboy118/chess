# frozen_string_literal: false

# this class creates the board with the help of the Squares class
class Board
  attr_reader :board, :player1, :player2, :current_player, :counter
  attr_accessor :game_message
  
  include ShowBoard
  include GameMessages
  include PlayerInput
  include ValidatePieceSelection

  def initialize(player1, player2 = nil)
    @board = []
    @counter = 1
    @player1 = player1
    @player2 = player2
    @current_player = nil
    @game_message = ''
    create_board
  end

  def create_board
    (0..7).each do |vertical|
      (0..7).each do |horizontal|
        @board.push(Square.new([horizontal, vertical]))
      end
    end
    setup_board
    # board.each { |board| p board.position}
  end
  

  def game_cycle
    GameMessages.whos_who(player1, player2)
    while player1.winner.nil? && player2.winner.nil?
      counter.odd? ? player_input(player1) : board.player_input(player2)
      counter += 1
    end
  end

  def player_input(player)
    @current_player = player
    grid_select
    # p current_player.selected_grid
    # I NEED TO ADD A METHOD HERE SIMILAR TOP THE  GRID_SELECT METHOD
    
    move_piece = PlayerInput.position(2)
    board.validate_move(move_piece, player)
  end

  def grid_select
    current_player.selected_grid = input_intro(1)
    current_player.selected_grid = select_piece_retry(1) until validate_piece == true
  end

  def find_square(input)
    board.each do |square|
      return square if square.position == input
    end
  end
end
