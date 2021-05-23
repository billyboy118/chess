# frozen_string_literal: false

# this module if to determine if the King has been put in check mate
module CheckMate
  def start_check_mate
    colour = current_player.colour == 'Black' ? 'White' : 'Black'
    start_turn_identify_check(colour)
    # if player is in check then searchy for checkmate =, if they are in check mate end the game and give a load of options
  end
end
