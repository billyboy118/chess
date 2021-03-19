# frozen_string_literal: false

# module for individual chess classes to assign unicode piece
module ChessPieces
  def get_piece(piece_name, colour)
    black_pieces = { 'Bishop' => "\u2657", 'King' => "\u2654", 'Knight' => "\u2658",
                     'Pawn' => "\u2659", 'Queen' => "\u2655", 'Rook' => "\u2656" }

    white_pieces = { 'Bishop' => "\u265D", 'King' => "\u265A", 'Knight' => "\u265E",
                     'Pawn' => "\u265F", 'Queen' => "\u265B", 'Rook' => "\u265C" }

    colour == 'Black' ? black_pieces[piece_name] : white_pieces[piece_name]
  end
end
