# frozen_string_literal: false

# this module is to establish if the game is a stalemate
module Stalemate
  def stalemate_check
    board.each do |square|
      current_piece = square.current_piece
      next if current_piece == ' '
      next if current_piece.colour == current_player.colour

      current_piece.board = board
      current_piece.move_from = Generic.find_index_with_string(current_piece.current_location)
      try_all_moves(square)
      return true if current_piece.potential_moves.length >= 1
    end
    'stalemate'
  end

  def try_all_moves(square)
    current_piece = square.current_piece
    current_piece.move_to = Square.new([0, 0])
    current_piece.potential_moves = []
    current_piece.can_move_be_made
    cycle_king_stalemate(current_piece) if current_piece.piece_name == 'King'
  end

  def cycle_king_stalemate(current_piece)
    temp_array = current_piece.potential_moves
    current_piece.potential_moves = []
    temp_array.each do |move|
      current_piece.move_to = Generic.find_square(move, board)
      next if current_piece.start_check == true

      current_piece.potential_moves << move
    end
  end
end
