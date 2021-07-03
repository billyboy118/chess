# frozen_string_literal: false

# this module is for the check and chackmate methods
module Check
  def start_check
    new_board = Marshal.load(Marshal.dump(board))
    return king_in_check(move_to, new_board, 2) if piece_name == 'King'

    king = find_king
    simulate_check_move(self, ' ', new_board)
    can_check_move_be_made = true if king_in_check(king, new_board) == true
    simulate_check_move(' ', self, new_board)
    can_check_move_be_made
  end

  # simulates the move being made by temporaruly moving the pieces around
  def simulate_check_move(to, from, new_board)
    move_to_index = Generic.find_square_index(move_to.position, new_board)
    move_from_index = Generic.find_square_index(move_from, new_board)
    new_board[move_to_index].current_piece = to
    new_board[move_from_index].current_piece = from
  end

  # This method identifies at the beginning of the players turn if they are in check
  def start_turn_identify_check(colour = nil)
    new_board = Marshal.load(Marshal.dump(board))
    colour = colour.nil? ? find_colour : colour
    king = find_king(colour)
    king_in_check(king, new_board, nil, colour)
  end

  def find_colour
    instance_of?(Board) ? current_player.colour : colour
  end

  # Identifies the playes king whos turn it is
  def find_king(colour = find_colour, new_board = board)
    new_board.each do |square|
      current_piece = square.current_piece
      next if current_piece == ' '
      next if current_piece.colour != colour
      return square if current_piece.piece_name == 'King'
    end
  end

  # Identifies if the players king is in check
  def king_in_check(king, new_board, checkmate = nil, colour = find_colour)
    simulate_check_move(self, ' ', new_board) if checkmate == 2
    king = find_king(self.colour, new_board) if checkmate == 2
    new_board.each do |square|
      current_piece = square.current_piece
      next if square.current_piece == ' '
      next if current_piece.colour == colour
      return true if cycle_check_pieces(king, square, new_board, checkmate) == true
    end
  end

  def cycle_check_pieces(king, square, new_board, checkmate = nil)
    piece = square.current_piece
    case piece.piece_name
    when 'Queen', 'Rook', 'Bishop' then piece.loop_piece_check(king, square, new_board, checkmate)
    when 'King' then piece.calculate_king_check(square, king)
    when 'Pawn' then calculate_pawn_check(square, king, new_board, checkmate)
    else
      piece.calculate_positions_check(square)
      return piece.potential_moves = moves if checkmate == 1
      return true if piece.potential_moves.include?(king.position)
    end
  end

  # rubocop: disable Metrics/AbcSize
  # rubocop: disable Metrics/CyclomaticComplexity
  def loop_piece_check(king, square, new_board, checkmate = nil)
    return loop_checkmate(square, new_board) if checkmate == 1

    moves.each do |move|
      new_move = square.position
      8.times do
        new_move = [new_move[0] + move[0], new_move[1] + move[1]]
        break if new_move.any? { |num| num.negative? || num > 7 }
        break if piece_in_path_check(new_move, king, new_board) == true
        return true if new_move == king.position
      end
    end
  end
  # rubocop: enable Metrics/AbcSize
  # rubocop: enable Metrics/CyclomaticComplexity

  # checks that no pieces is in the path when checking for check
  def piece_in_path_check(new_move, king, new_board)
    incrimented_square = Generic.find_square(new_move, new_board)
    return false if new_move == king.position
    return true if incrimented_square.current_piece != ' '
  end

  # calculates king moves and returns true if king put the king in check
  def calculate_king_check(square, king)
    calculate_positions_check(square)
    return true if potential_moves.include?(king.position)
  end

  # calculates positions for a number of the different pieces
  def calculate_positions_check(square)
    square.current_piece.potential_moves = []
    move_from = square.position
    moves.each do |move|
      new_move = [move_from[0] + move[0], move_from[1] + move[1]]
      square.current_piece.potential_moves.push(new_move)
    end
  end

  # determines if the pawn is able to put the king in check
  def calculate_pawn_check(square, king, new_board, checkmate = nil)
    piece = square.current_piece
    piece.allocate_moves
    piece.move_from = square.position
    return piece.can_pawn_take(new_board) if checkmate == 1

    piece.moves.delete_at(3)
    piece.moves.delete_at(0)
    piece.calculate_positions_check(square)
    return true if piece.potential_moves.include?(king.position)
  end
end
