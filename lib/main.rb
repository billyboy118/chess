# frozen_string_literal: false

$LOAD_PATH << File.join(File.dirname(__FILE__), 'modules')
$LOAD_PATH << File.join(File.dirname(__FILE__), 'pieces')
require 'colorize'
require 'generic'
require 'start_text'
require 'two_player'

require 'tty-prompt'

def start
  StartText.welcome_message
  game_mode = StartText.lets_play
  game_mode == 'Two Player' ? TwoPlayer.initate_two_player : initate_single_player

end

def initate_single_player
  StartText.welcome_message
  puts "\n Single player currently unavailable"
end

start
