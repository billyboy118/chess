# frozen_string_literal: false

# this class creates the board with the help of the Squares class
class Board
  attr_reader :board, :player1, :player2, :current_player
  attr_accessor :game_message, :counter, :game_phase

  include ShowBoard
  include GameMessages
  include PlayerInput
  include ValidatePieceSelection
  include NavigateGame
  include Check
  include CheckMate

  def initialize(player1, player2 = nil)
    @board = []
    @counter = 1
    @player1 = player1
    @player2 = player2
    @current_player = nil
    @game_message = ''
    @game_phase = 1
    create_board
  end

  def create_board
    (0..7).each do |vertical|
      (0..7).each do |horizontal|
        @board.push(Square.new([horizontal, vertical]))
      end
    end
    setup_board
  end

  def game_cycle
    GameMessages.whos_who(player1, player2)
    while player1.winner.nil? && player2.winner.nil?
      @current_player = select_player
      player_input
      current_player.selected_piece.potential_moves = []
      @counter += 1
      @game_phase = 1
      end_game if start_check_mate == 'end game'
    end
  end

  def select_player
    if counter.odd?
      player1
    else
      player2
    end
  end

  def end_game

  end 
end
