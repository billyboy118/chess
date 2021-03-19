# frozen_string_literal: false

# module for individual chess classes to assign unicode piece
module ChessPieces
  def get_piece(piece_name, colour)
    colour == 'Black' ? get_black(piece_name) : get_white(piece_name)
  end

  def get_black(piece_name)
    case piece_name
    when 'Bishop'
      "\u2658"
    end

  end
end 