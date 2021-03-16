# frozen_string_literal: false

# module to start the game off
module StartText
  def self.welcome_message
    Generic.clear
puts <<~HEREDOC
         _____   _       _   _____    _____     _____
        /  ___| | |     | | |  ___|  / ____|   / ____|
       |  /     | |     | | | |     / /       / /
       | |      | |_____| | | |___  \\ \\____   \\ \\____
       | |      |  _____  | |  ___|  \\____ \\   \\____ \\
       | |      | |     | | | |           \\ \\       \\ \\
       |  \\___  | |     | | | |___    ____/ /  _____/ /
        \\_____| |_|     |_| |_____|  |_____/  |______/
        
HEREDOC
puts '            Lets play some chess'.light_blue
  end

  def self.lets_play
    prompt = TTY::Prompt.new
    greeting = puts "\nWhat would you like to do?"
    choices = ['New Game', 'Load Game (not currently available)']
    selection = prompt.select(greeting, choices)

    selection == 'New Game' ? new_game : load_game
  end

  def self.new_game
    Generic.clear
    welcome_message

    prompt = TTY::Prompt.new
    greeting = puts "\nWhat game mode would you like to play?"
    choices = ['Two Player', 'Single Player (not currently available)']
    prompt.select(greeting, choices)

    #selection == 'Two Player' ? initiate_two_player : initiate_    

  end

  def self.load_game
    Generic.clear
    welcome_message
    puts "\n Load game currently unavailable"
    sleep 3
    lets_play
  end




end