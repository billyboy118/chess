# frozen_string_literal: false

$LOAD_PATH << File.join(File.dirname(__FILE__), 'modules')
$LOAD_PATH << File.join(File.dirname(__FILE__), 'classes')
$LOAD_PATH << File.join(File.dirname(__FILE__), './classes/pieces')

require 'show_board'
require 'generic'
require 'start_text'
require 'two_player'
require 'player'
require 'square'
require 'instruction'
require 'game_messages'
require 'move_input'
require 'validate_piece_selection'
require 'navigate_game'
require 'check'
require 'check_mate'
require 'save_load'
require 'board'
require 'chess_pieces'
require 'en_passant'
require 'promotion'

require 'pieces'
require 'bishop'
require 'king'
require 'knight'
require 'pawn'
require 'queen'
require 'rook'

require 'colorize'
require 'tty-prompt'

def start
  StartText.welcome_message
  counter = 0
  loop do
    game_mode = StartText.lets_play(counter)
    game_mode == 'Two Player' ? TwoPlayer.initate_two_player : initate_single_player
    counter += 1
  end
end

def initate_single_player
  StartText.welcome_message
  puts "\n Single player currently unavailable"
end

start
# bishop = Bishop.new('Bill', 'Black')
# puts bishop.piece
