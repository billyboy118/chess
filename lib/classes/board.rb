# frozen_string_literal: false

# this class creates the board with the help of the Squares class
class Board
  attr_reader :board, :player1, :player2, :current_player, :counter
  

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
    current_player.selected_piece = input_intro(1)
    # I think I will add an if statement here where whereI will incorporate the return from PlayerInput.additional options
    validate_piece
    move_piece = PlayerInput.position(2)
    board.validate_move(move_piece, player)
  end

  def find_square

  end

  
end
