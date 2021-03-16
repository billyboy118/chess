# frozen_string_literal: false

$LOAD_PATH << File.join(File.dirname(__FILE__), 'modules')
$LOAD_PATH << File.join(File.dirname(__FILE__), 'pieces')
require 'colorize'
require 'generic'
require 'start_text'
require 'tty-prompt'

def start
  StartText.welcome_message
  game_mode = StartText.lets_play

  puts game_mode
end

start
