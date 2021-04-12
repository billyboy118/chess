# frozen_string_literal: false

# class which create pawn pieces to put on the board
class Pawn < Pieces
  attr_accessor :en_passant_pieces

  @@en_passant_pieces = []
  @@en_passant = 0

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
    moves.pop if no_of_moves.positive?
    can_pawn_take
    en_passant_take
    calculate_positions
    en_passant_eligable if potential_moves.include?(move_to.position)
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

  def en_passant_take

  end

  def correct_range(position)
    position.all? { |num| num >= 0 && num < 8 }
  end

  def look_potential_moves(position)
    position.nil? || position.current_piece == ' '
  end

  def calculate_left(num = 0)
    left = [move_from[0] + moves[1][0], move_from[1] + moves[1][1] + num]
    Generic.find_square(left, board) if correct_range(left)
  end

  def calculate_right(num = 0)
    right = [move_from[0] + moves[2][0], move_from[1] + moves[2][1] + num]
    Generic.find_square(right, board) if correct_range(right)
  end

  def calculate_front
    front = [move_from[0] + moves[0][0], move_from[1] + moves[0][1]]
    Generic.find_square(front, board) if correct_range(front)
  end

  def calculate_double_front
    return if no_of_moves.positive?

    double_front = [move_from[0] + moves[3][0], move_from[1] + moves[3][1]]
    Generic.find_square(double_front, board) if correct_range(double_front)
  end

  def en_passant_eligable
    if no_of_moves == 1 && (move_to.position[1] == 3 || move_to.position[1] == 4)
      allocate_moves
      possible_moves
      @@en_passant_pieces.unshift(self)
      puts @no_of_moves

      # puts "thi is current #{self}"
      # puts @@en_passant_pieces
    end
    true # true is needed otherwise this will be seen as an illegal move
  end

  def possible_moves
    num = move_to.position[1] == 3 ? 1 : -1
    left_piece = calculate_left(num)
    right_piece = calculate_right(num)
    en_passant_selection([left_piece, right_piece])
  end

  def en_passant_selection(pieces)
    pieces.each do |piece|
      next if piece.nil?

      if piece.current_piece != ' ' && piece.current_piece.piece_name == 'Pawn'
        @@en_passant_pieces << piece.current_piece
        @@passant_eligable = 'Yes'
      end
    end
  end
end
