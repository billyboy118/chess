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

  def self.lets_play(counter)
    prompt = TTY::Prompt.new
    greeting = counter.positive? ? "\nWhat would you like to do now?" : "\nWhat would you like to do?"
    greeting = puts greeting
    choices = ['New Game', 'Load Game']
    selection = prompt.select(greeting, choices)

    selection == 'New Game' ? new_game : SaveLoad.select_loaded_file
  end

  def self.new_game
    Generic.clear
    welcome_message

    prompt = TTY::Prompt.new
    greeting = puts "\nWhat game mode would you like to play?"
    choices = ['Two Player', 'Single Player (not currently available)']
    prompt.select(greeting, choices)
  end

  # def self.load_game
  #  Generic.clear
  #  welcome_message
  #  puts "\n Load game currently unavailable"
  #  sleep 3
  #  lets_play
  # end
end
