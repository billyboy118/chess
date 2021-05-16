# frozen_string_literal: false

# this module is for the check and chackmate methods
module Check

  def start_check
    #start_turn_identify_check
    # identify_move_into_check

  end

  # This method identifies at the beginning of the players turn if they are in check
  def start_turn_identify_check
    king = find_king
    is_king_in_check(king)
    puts king
  end

  # Identifies the playes king whos turn it is
  def find_king
    board.each do |square|
      current_piece = square.current_piece
      next if current_piece == ' '
      next if current_piece.colour != current_player.colour
      return current_piece if current_piece.piece_name == 'King'
    end
  end

  # Identifies if the players king is in check
  def is_king_in_check(king)

  end

  # def identify_check
  #  piece_name == 'King'
  # end
end
