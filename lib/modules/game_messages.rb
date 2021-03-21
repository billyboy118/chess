# frozen_string_literal: false

# this module provides a number of messsages to be used thoughout the game
module GameMessages
  def self.whos_who(player1, player2)
    puts "\nHello #{player1.name} and #{player2.name}!\n\n\u265F #{player1.name} your colour is white"
    puts "\u2659 #{player2.name} your colour is black\n\nWhites go first."
    # sleep 5
  end

  def next_turn(player)
    show_board
    puts "#{player.name} it is your go."
  end
end
