# frozen_string_literal: false
# rubocop: disable Metrics/ModuleLength 
# this module if to determine if the King has been put in check mate
module CheckMate
  def start_check_mate
    colour = check_mate_colour
    return unless start_turn_identify_check(colour) == true

    return 'end game' if cycle_opposition_pieces(colour) != true
  end

  def check_mate_colour(my_piece = current_player.colour)
    my_piece == 'Black' ? 'White' : 'Black'
  end

  def cycle_opposition_pieces(colour)
    king = find_king(colour)
    king.current_piece.board = board
    board.each do |square|
      next if square.current_piece == ' '
      next if square.current_piece.colour == current_player.colour

      return true if square.current_piece.cycle_opposition_moves(square, king, board, colour) == true
    end
  end

  # rubocop: disable Metrics/AbcSize
  def cycle_opposition_moves(square, king, board, colour)
    available_piece_moves = cycle_check_pieces(king, square, board, 1) #i can get rid of this and put all moves in the instace variables
    available_piece_moves = moves if piece_name == 'Pawn'
    available_piece_moves.each do |moving_to|
      new_position = new_positions(moving_to, piece_name, current_location)
      next if new_position.any? { |num| num.negative? || num > 7 }
      if board[Generic.find_square_index(new_position, board)].current_piece != ' '
        next if board[Generic.find_square_index(new_position, board)].current_piece.colour == colour
      end

      new_board = Marshal.load(Marshal.dump(board))
      new_board = simulate_checkmate_moves(self, ' ', new_position, new_board)
      king = find_king_checkmate(new_board, colour)
      return true if king_in_checkmate_final(king, new_board, king.current_piece.colour) == true
    end
  end
  # rubocop: enable Metrics/AbcSize

  def find_king_checkmate(new_board, colour)
    new_board.each do |square|
      current_piece = square.current_piece
      next if current_piece == ' '
      next if current_piece.colour != colour
      return square if current_piece.piece_name == 'King'
    end
  end

  def new_positions(moving_to, piece_name, current_location)
    current_position = Generic.find_index_with_string(current_location)
    pieces = %w[Pawn Knight King]
    if pieces.include?(piece_name)
      [moving_to[0] + current_position[0], moving_to[1] + current_position[1]]
    else
      moving_to
    end
  end

  def simulate_checkmate_moves(to, from, moving_to, new_board)
    move_to_index = Generic.find_square_index(moving_to, new_board)
    string_convert_move_from_index = Generic.find_index_with_string(current_location)
    move_from_index = Generic.find_square_index(string_convert_move_from_index, new_board)
    new_board[move_to_index].current_piece = to
    new_board[move_from_index].current_piece = from
    new_board
  end

  # rubocop: disable Metrics/AbcSize
  def loop_checkmate(square, new_board)
    moves.each do |move|
      new_move = square.position
      8.times do
        new_move = [new_move[0] + move[0], new_move[1] + move[1]]
        break if new_move.any? { |num| num.negative? || num > 7 }
        break if piece_in_path_checkmate(new_move, new_board) == true

        potential_moves.push(new_move)
      end
    end
    potential_moves
  end
  # rubocop: enable Metrics/AbcSize

  def piece_in_path_checkmate(new_move, new_board)
    incrimented_square = Generic.find_square(new_move, new_board)
    return true if incrimented_square.current_piece != ' '
  end

  def calculate_pawn_checkmate(square, new_board)
    piece = square.current_piece
    piece.allocate_moves
    piece.moves.delete_at(3) if piece.no_of_moves.positive?
    piece.moves.delete_at(2) if delete_pawn_moves_checkmate(new_board) == true
    piece.moves.delete_at(1) if delete_pawn_moves_checkmate(new_board) == true
  end

  # this method is used for the simulated board where is will look at every possible move and if one of these moves
  # dont result in check then it need to be highlighted, if not it is the end of the game
  def king_in_checkmate_final(king, new_board, colour = find_colour)
    check_counter = 0
    new_board.each do |square|
      current_piece = square.current_piece
      next if current_piece == ' '
      next if current_piece.colour == colour

      new_counter = cycle_checkmate_pieces_final(king, square, new_board)
      check_counter += new_counter if new_counter.is_a?(Numeric)
    end
    return true if check_counter.zero?
  end

  def cycle_checkmate_pieces_final(king, square, new_board)
    piece = square.current_piece
    case piece.piece_name
    when 'Queen', 'Rook', 'Bishop' then piece.loop_piece_checkmate_final(king, square, new_board)
    when 'King' then piece.calculate_king_checkmate_final(square, king)
    when 'Pawn' then calculate_pawn_checkmate_final(square, king)
    else
      piece.calculate_positions_check(square)
      return 1 if piece.potential_moves.include?(king.position)
    end
  end

  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
  def loop_piece_checkmate_final(king, square, new_board)
    moves.each do |move|
      temp_array = []
      new_move = square.position
      8.times do
        new_move = [new_move[0] + move[0], new_move[1] + move[1]]
        break if new_move.any? { |num| num.negative? || num > 7 }
        break if piece_in_path_check(new_move, king, new_board) == true

        temp_array << new_move
        return 1 if temp_array.include?(king.position)
      end
    end
  end
  # rubocop: enable Metrics/AbcSize
  # rubocop: enable Metrics/MethodLength

  def calculate_king_checkmate_final(square, king)
    calculate_positions_check(square)
    return 1 if potential_moves.include?(king.position)
  end

  def calculate_pawn_checkmate_final(square, king)
    piece = square.current_piece
    piece.allocate_moves
    piece.moves.delete_at(3)
    piece.moves.delete_at(0)
    piece.calculate_positions_check(square)
    return 1 if piece.potential_moves.include?(king.position)
  end
end
