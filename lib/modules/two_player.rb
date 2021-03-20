# frozen_string_literal: false

# some random generic modules to use througout
module TwoPlayer
  def self.initate_two_player
    names = player_names(2)
    player1 = Player.new(names[0], 'White')
    player2 = Player.new(names[1], 'Black')
    Board.new(player1, player2)
  end

  def self.player_names(num)
    names = []
    num.times do |i|
      StartText.welcome_message
      puts "\n Player #{i + 1} what is your name?"
      names.push(gets.chomp)
    end
    StartText.welcome_message
    puts "\nHello #{names[0]} & #{names[1]} lets play some chess!"
    names
  end
end
