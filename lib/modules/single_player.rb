# frozen_string_literal: false

# module for single player mode
module SinglePlayer
  def self.initate_single_player
    name = player_name
    StartText.welcome_message
    puts "\nHello #{name} lets play some chess!"
    sleep 2
    player1 = Player.new(name, 'White')
    computer = Player.new('Computer', 'Black')
    board = Board.new(player1, computer)
    board.game_cycle
  end

  def self.player_name
    StartText.welcome_message
    puts "\nWhat is your name?"
    while (name = gets.chomp)
      case name
      when 'Computer' then puts 'That name is taken please try again'
      else return name
      end
    end
  end
end
