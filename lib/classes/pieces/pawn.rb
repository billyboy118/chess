# frozen_string_literal: false

# class which create pawn pieces to put on the board
class Pawn < Pieces
  attr_accessor :en_passant_pieces, :en_passant_move

  @@en_passant_pieces = []
  @@en_passant = 0

  include PlayerInput

  def initialize(name, colour)
    super(name, colour)
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

  # rubocop:disable Metrics/AbcSize
  def calculate_double_front
    return if no_of_moves.positive?

    double_front = [move_from[0] + moves[3][0], move_from[1] + moves[3][1]]
    Generic.find_square(double_front, board) if correct_range(double_front)
  end
  # rubocop:enable Metrics/AbcSize

  # this move method identifies the piece that will need to be removed as a result of the en_passant move
  def pawn_move
    position_index = Generic.find_square_index(en_passant_move, board)

    position_index -= 8 if colour == 'White'
    position_index += 8 if colour == 'Black'
  
    puts "position index = #{board[position_index].current_piece.current_location}"
    puts self.current_location
    puts board[position_index - 1].current_piece
    return if board[position_index - 1].current_piece == self

    puts 'it works'
    # here i need to run through each of the temp moves where I wil add the number to position _index
    # I will then look at this index (need to create a new method for this in generic) and if there is not
    # a piece there I will know that this is a en_passant move, I may then be able to figure out through the
    # index which piece of the oposition I will need to remove
    #moves.each_with_index do |move, index|
    #  check_square = []
    #end
  end

end
