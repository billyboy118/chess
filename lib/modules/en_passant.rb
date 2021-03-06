# frozen_string_literal: false

# this module if used for the  en passant move
module EnPassant
  EN_PASSANT_WHITE = [[-1, 1], [1, 1]].freeze
  EN_PASSANT_BLACK = [[-1, -1], [1, -1]].freeze

  # second stage
  def en_passant_take
    return if game.passant_eligable == 'No'

    pieces = game.en_passant_pieces
    piece = Marshal.load(Marshal.dump(pieces[0]))
    en_passant_take_move(piece)
  end

  # second stage
  def en_passant_take_move(piece)
    current_position = piece.move_to.position
    current_position[1] = current_position[1] + 1 if colour == 'White'
    current_position[1] = current_position[1] - 1 if colour == 'Black'
    @en_passant_move = current_position
    potential_moves << current_position
  end

  # first stage
  def en_passant_eligable
    if move_to.position[1] == 3 || move_to.position[1] == 4
      allocate_moves
      possible_moves
      game.en_passant_pieces.unshift(self)
    end
    true # true is needed otherwise this will be seen as an illegal move
  end

  # first stage
  def possible_moves
    num = move_to.position[1] == 3 ? 1 : -1
    left_piece = calculate_left(board, num)
    right_piece = calculate_right(board, num)
    en_passant_selection([left_piece, right_piece])
  end

  # first stage
  def en_passant_selection(pieces)
    pieces.each do |piece|
      next if piece.nil?

      if piece.current_piece != ' ' && piece.current_piece.piece_name == 'Pawn'
        game.en_passant_pieces << piece.current_piece
        passant_eligable_selection('Yes')
      end
    end
  end
end
