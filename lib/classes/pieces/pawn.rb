# frozen_string_literal: false

# class which create pawn pieces to put on the board
class Pawn < Pieces
  def initialize(name, colour)
    super(name, colour)
    @piece_name = 'Pawn'
    @piece = get_piece(piece_name, @colour)
    @moves = []
  end

  def allocate_moves
    return @moves = [[0, 1], [-1, 1], [1, 1], [0, 2]] if colour == 'White'

    @moves = [[0, -1], [-1, -1], [1, -1], [0, -2]]
  end

  def calculate_pawn
    allocate_moves
    moves.pop if has_piece_moved == 'Yes'
    can_pawn_take
    calculate_positions
    return true if potential_moves.include?(move_to.position)
  end

  def can_pawn_take
    left = calculate_left
    right = calculate_right
    front = calculate_front
    double_front = calculate_double_front

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

  def calculate_left
    left = [move_from[0] + moves[1][0], move_from[1] + moves[1][1]]
    Generic.find_square(left, board) if correct_range(left)
  end

  def calculate_right
    right = [move_from[0] + moves[2][0], move_from[1] + moves[2][1]]
    Generic.find_square(right, board) if correct_range(right)
  end

  def calculate_front
    front = [move_from[0] + moves[0][0], move_from[1] + moves[0][1]]
    Generic.find_square(front, board) if correct_range(front)
  end

  def calculate_double_front
    return if has_piece_moved == 'Yes'

    double_front = [move_from[0] + moves[3][0], move_from[1] + moves[3][1]]
    Generic.find_square(double_front, board) if correct_range(double_front)
  end
end
