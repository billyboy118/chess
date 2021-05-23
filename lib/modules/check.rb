# frozen_string_literal: false

# this module is for the check and chackmate methods
module Check

  def start_check
    return king_in_check(move_to) if piece_name == 'King'

    king = find_king
    simulate_move
    king_in_check(king)
    # need to add something here which will take into account the playes move when blocking the check move
    # I will need to simulate the move the player will make - this could involve having to temporarly add a marker to the board
  end

  def simulate_move

  end

  # This method identifies at the beginning of the players turn if they are in check
  def start_turn_identify_check
    king = find_king
    puts 'You are in Check' if king_in_check(king) == true
  end

  # Identifies the playes king whos turn it is
  def find_king
    new_board = board # instance_of?(Board) ? board : self.board
    new_board.each do |square|
      player_colour = instance_of?(Board) ? current_player.colour : colour
      current_piece = square.current_piece
      next if current_piece == ' '
      next if current_piece.colour != player_colour
      return square if current_piece.piece_name == 'King'
    end
  end

  # Identifies if the players king is in check
  def king_in_check(king)
    player_colour = instance_of?(Board) ? current_player.colour : colour
    board.each do |square|
      current_piece = square.current_piece
      next if current_piece == ' '
      next if current_piece.colour == player_colour
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
