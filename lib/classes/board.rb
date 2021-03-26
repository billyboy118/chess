# frozen_string_literal: false

# this class creates the board with the help of the Squares class
class Board
  attr_reader :board, :player1, :player2, :current_player
  attr_accessor :game_message, :counter

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
      @current_player = if counter.odd?
                          player1
                        else
                          player2
                        end
      player_input
      @counter += 1
    end
  end

  def player_input
    grid_select
    move_to
  end

  def grid_select
    current_player.selected_grid = input_intro(1)
    current_player.selected_grid = select_piece_retry(1) until validate_piece == true
  end

  def move_to
    current_player.selected_move = input_intro(2)
    current_player.selected_move = select_piece_retry(2) until validate_move == true
  end

  def find_square(input)
    board.each do |square|
      return square if square.position == input
    end
  end
end
