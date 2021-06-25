# frozen_string_literal: false

# module for two player mode
module TwoPlayer
  def self.initate_two_player
    names = player_names
    player1 = Player.new(names[0], 'White')
    player2 = Player.new(names[1], 'Black')
    board = Board.new(player1, player2)
    board.game_cycle
  end

  def self.player_names
    names = []
    2.times do |i|
      StartText.welcome_message
      puts "\nPlayer #{i + 1} what is your name?"
      names.push(gets.chomp)
    end
    StartText.welcome_message
    puts "\nHello #{names[0]} & #{names[1]} lets play some chess!"
    sleep 2
    names
  end
end
