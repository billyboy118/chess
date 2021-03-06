# frozen_string_literal: false

# this class creates the board with the help of the Squares class
class Board
  attr_accessor :game_message, :counter, :game_phase, :board, :player1, :player2, :current_player, :passant_eligable, :passant_counter, :en_passant_pieces, :concede

  include ShowBoard
  include GameMessages
  include PlayerInput
  include ValidatePieceSelection
  include NavigateGame
  include Check
  include CheckMate
  include SaveLoad
  include SinglePlayer
  include Stalemate

  # rubocop: disable Metrics/MethodLength
  def initialize(player1, player2 = nil)
    @board = []
    @counter = 1
    @player1 = player1
    @player2 = player2
    @current_player = nil
    @game_message = ''
    @game_phase = 1
    @concede = 'No'

    @passant_eligable = 'No'
    @passant_counter = 0
    @en_passant_pieces = []

    create_board unless player1.nil?
  end
  # rubocop: enable Metrics/MethodLength

  def create_board
    (0..7).each do |vertical|
      (0..7).each do |horizontal|
        @board.push(Square.new([horizontal, vertical]))
      end
    end
    setup_board
  end

  # rubocop: disable Metrics/AbcSize
  def game_cycle
    GameMessages.whos_who(player1, player2) unless counter.positive?
    while player1.winner.nil? && player2.winner.nil?
      @current_player = select_player
      current_player.name == 'Computer' ? select_computer_move : player_input
      break if concede_game == true

      current_player.selected_piece.potential_moves = []
      @counter += 1
      @game_phase = 1
      break if end_game == true
    end
  end
  # rubocop: enable Metrics/AbcSize

  def select_player
    if counter.odd?
      player1
    else
      player2
    end
  end

  def end_game
    if start_check_mate == 'end game'
      show_board("Well done #{current_player.name} you have won, the opposition is in checkmate!")
      return true
    elsif stalemate_check == 'stalemate'
      show_board('This game is at a stalemate therefore it is a draw!')
      return true
    end
    current_player.selected_piece.potential_moves = []
  end

  def concede_game
    return unless concede == 'Yes'

    show_board("#{current_player.name} you have conceded, your opponent wins!")
    true
  end
end
