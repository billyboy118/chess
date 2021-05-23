# frozen_string_literal: false

# this module is for the check and chackmate methods
module Check
  def start_check
    return king_in_check(move_to) if piece_name == 'King'

    king = find_king
    simulate_check_move(self, ' ')
    can_check_move_be_made = true if king_in_check(king) == true
    simulate_check_move(' ', self)
    can_check_move_be_made
  end

  # simulates the move being made by temporaruly moving the pieces around
  def simulate_check_move(to, from)
    move_to_index = Generic.find_square_index(move_to.position, board)
    move_from_index = Generic.find_square_index(move_from, board)
    board[move_to_index].current_piece = to
    board[move_from_index].current_piece = from
  end

  # This method identifies at the beginning of the players turn if they are in check
  def start_turn_identify_check(colour = nil)
    colour = colour.nil? ? find_colour : colour
    king = find_king(colour)
    king_in_check(king, colour)
  end

  def find_colour
    instance_of?(Board) ? current_player.colour : colour
  end

  # Identifies the playes king whos turn it is
  def find_king(colour = find_colour)
    board.each do |square|
      current_piece = square.current_piece
      next if current_piece == ' '
      next if current_piece.colour != colour
      return square if current_piece.piece_name == 'King'
    end
  end

  # Identifies if the players king is in check
  def king_in_check(king, colour = find_colour)
    board.each do |square|
      current_piece = square.current_piece
      next if current_piece == ' '
      next if current_piece.colour == colour
      return true if cycle_check_pieces(king, square) == true
    end
  end

  def cycle_check_pieces(king, square)
    piece = square.current_piece
    case piece.piece_name
    when 'Queen', 'Rook', 'Bishop' then piece.loop_piece_check(king, square, board)
    when 'King' then piece.calculate_king_check(square, king)
    when 'Pawn' then calculate_pawn_check(square, king)
    else
      piece.calculate_positions_check(square)
      return true if piece.potential_moves.include?(king.position)
    end
  end

  # rubocop: disable Metrics/AbcSize
  def loop_piece_check(king, square, board)
    moves.each do |move|
      new_move = square.position
      8.times do
        new_move = [new_move[0] + move[0], new_move[1] + move[1]]
        break if new_move.any? { |num| num.negative? || num > 7 }
        break if piece_in_path_check(new_move, king, board) == false
        return true if new_move == king.position
      end
    end
  end
  # rubocop: enable Metrics/AbcSize

  # checks that no pieces is in the path when checking for check
  def piece_in_path_check(new_move, king, board)
    incrimented_square = Generic.find_square(new_move, board)
    return false if new_move != king.position && incrimented_square.current_piece != ' '
  end

  # calculates king moves and returns true if king put the king in check
  def calculate_king_check(square, king)
    calculate_positions_check(square)
    return true if potential_moves.include?(king.position)
  end

  # calculates positions for a number of the different pieces
  def calculate_positions_check(square)
    move_from = square.position
    moves.each do |move|
      new_move = [move_from[0] + move[0], move_from[1] + move[1]]
      potential_moves.push(new_move)
    end
  end

  # determines if the pawn is able to put the king in check
  def calculate_pawn_check(square, king)
    piece = square.current_piece
    piece.allocate_moves
    piece.moves.delete_at(3)
    piece.moves.delete_at(0)
    piece.calculate_positions_check(square)
    return true if piece.potential_moves.include?(king.position)
  end
end
