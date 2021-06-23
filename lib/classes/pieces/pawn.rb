# frozen_string_literal: false

# class which create pawn pieces to put on the board
class Pawn < Pieces
  attr_accessor :en_passant_pieces, :en_passant_move, :moves

  include PlayerInput

  def initialize(name, colour, game)
    super(name, colour, game)
    @piece_name = 'Pawn'
    @piece = get_piece(piece_name, @colour)
    @moves = []
    @en_passant_move = nil
  end

  def allocate_moves
    return @moves = [[0, 1], [-1, 1], [1, 1], [0, 2]] if colour == 'White'

    @moves = [[0, -1], [-1, -1], [1, -1], [0, -2]]
  end

  def calculate_pawn
    allocate_moves
    moves.pop if no_of_moves.positive?
    can_pawn_take
    en_passant_take
    calculate_positions
    en_passant_eligable if potential_moves.include?(move_to.position)
  end

  def can_pawn_take(new_board = board)
    left = calculate_left(new_board)
    right = calculate_right(new_board)
    front = calculate_front(new_board)
    double_front = calculate_double_front(new_board)
    moves.delete_at(2) if look_potential_moves(right)
    moves.delete_at(1) if look_potential_moves(left)
    moves.delete_at(0) unless look_potential_moves(front)
    moves.pop unless look_potential_moves(double_front)
  end

  def correct_range(position)
    position.all? { |num| num >= 0 && num < 8 }
  end

  def look_potential_moves(position)
    position.nil? || position.current_piece == ' '
  end

  def calculate_left(new_board, num = 0)
    left = [move_from[0] + moves[1][0], move_from[1] + moves[1][1] + num]
    Generic.find_square(left, new_board) if correct_range(left)
  end

  def calculate_right(new_board, num = 0)
    right = [move_from[0] + moves[2][0], move_from[1] + moves[2][1] + num]
    Generic.find_square(right, new_board) if correct_range(right)
  end

  def calculate_front(new_board)
    front = [move_from[0] + moves[0][0], move_from[1] + moves[0][1]]

    Generic.find_square(front, new_board) if correct_range(front)
  end

  def calculate_double_front(new_board)
    return if no_of_moves.positive?

    double_front = [move_from[0] + moves[3][0], move_from[1] + moves[3][1]]
    Generic.find_square(double_front, new_board) if correct_range(double_front)
  end

  # this move method identifies the piece that will need to be removed as a result of the en_passant move
  def pawn_move
    position_index = Generic.find_square_index(en_passant_move, board)

    colour == 'White' ? pawn_move_white(position_index) : pawn_move_black(position_index)
  end

  def pawn_move_white(position_index)
    index_move = [9, 7]
    index_move.each do |num|
      index = position_index - num
      if board[position_index - num].current_piece == self
        index = num == 9 ? index + 1 : index - 1
        board[index].current_piece = ' '
      end
    end
  end

  def pawn_move_black(position_index)
    index_move = [9, 7]
    index_move.each do |num|
      index = position_index + num
      if board[position_index + num].current_piece == self
        index = num == 9 ? index - 1 : index + 1
        board[index].current_piece = ' '
      end
    end
  end
end
