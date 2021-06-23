# frozen_string_literal: false

# class which create king pieces to put on the board
class King < Pieces
  CASTLING_MOVES = [2, 58, 6, 62].freeze
  def initialize(name, colour, game)
    super(name, colour, game)
    @piece_name = 'King'
    @piece = get_piece(piece_name, @colour)
    @moves = [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]]
    @special_moves = []
  end

  def calculate_king
    calculate_positions
    return true if castling == true # return true if castlig == true # hide this so i can move the king anywhere
    return true if potential_moves.include?(move_to.position)

    # true
    false # to move king anywhere I can change this to a true
  end

  def castling
    return if no_of_moves.positive?

    # return if check == true
    move_index = Generic.find_square_index(move_to.position, board)
    return if check_colour(move_index) == false

    left_or_right(move_index)
  end

  # checks that the player is not trying to castle the oposing players piece
  def check_colour(move_index)
    sum = colour == 'White' ? 4 : 60
    sum -= move_index
    sum = sum.abs
    puts sum
    return true if sum == 2

    false
  end

  # determines if the player is castling to the left or the right
  def left_or_right(move_index)
    case move_index
    when 2, 58
      castling_check_squares(3)
    when 6, 62
      castling_check_squares(2)
    end
  end

  # checks that all the required squares to make the move are empty
  def castling_check_squares(checks)
    i = 0
    index = colour == 'White' ? 4 : 60
    checks.times do
      index -= 1 if checks == 3
      index += 1 if checks == 2
      break if board[index].current_piece != ' '

      i += 1
    end
    i == checks ? castling_move(checks) : false
  end

  def castling_move(left_right)
    return false if check_rook(left_right) == false

    move_rook(left_right)
    true
  end

  # looks at the move determines if is left or right and then decides if the rook is a legal move, if the rook is there
  def check_rook(left_right)
    move_index = Generic.find_square_index(move_from, board)
    case left_right
    when 3
      rook = board[move_index - 4]
    when 2
      rook = board[move_index + 3]
    end
    return false if rook.current_piece == ' ' || rook.current_piece.piece_name != 'Rook'

    rook.current_piece.no_of_moves.positive? ? false : true
  end

  # rubocop: disable Metrics/AbcSize
  def move_rook(left_right)
    move_index = Generic.find_square_index(move_from, board)
    case left_right
    when 3
      board[move_index - 1].current_piece = board[move_index - 4].current_piece
      board[move_index - 4].current_piece = ' '
    when 2
      board[move_index + 1].current_piece = board[move_index + 3].current_piece
      board[move_index + 3].current_piece = ' '
    end
  end
  # rubocop: enable Metrics/AbcSize
end
