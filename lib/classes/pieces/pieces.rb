# frozen_string_literal: false

# super class for all chess pieces to inherit from
class Pieces
  attr_reader :piece_name, :piece, :player_name, :colour, :moves, :special_moves
  attr_accessor :current_location, :move_from, :move_to, :board, :no_of_moves, :potential_moves, :en_passant_pieces, :counter, :passant_eligable, :game

  include ChessPieces
  include EnPassant
  include Promotion
  include ShowBoard
  include Check
  include CheckMate

  def initialize(name, colour, game)
    @player_name = name
    @colour = colour
    @piece = get_piece(piece_name, @colour)
    @current_location = nil
    @potential_moves = []
    @move_from = []
    @move_to = []
    @board = []
    @no_of_moves = 0
    @game = game
  end

  def passant_eligable_selection(choice)
    game.passant_eligable = choice
  end

  def legal_move(game_counter)
    return false if start_check == true
    return unless can_move_be_made == true

    game.passant_eligable = 'No' if game.passant_counter == game_counter
    game.passant_counter = game_counter
    true
  end

  def calculate_positions
    moves.each do |move|
      new_move = [move_from[0] + move[0], move_from[1] + move[1]]
      potential_moves.push(new_move)
    end
  end

  def can_move_be_made
    case piece_name
    when 'Queen', 'Rook', 'Bishop' then loop_piece
    when 'King' then calculate_king
    when 'Pawn' then calculate_pawn
    else
      calculate_positions
      check_stalemate_moves
      return true if potential_moves.include?(move_to.position)
    end
  end

  # rubocop: disable Metrics/AbcSize
  def loop_piece
    moves.each do |move|
      new_move = move_from
      8.times do
        new_move = [new_move[0] + move[0], new_move[1] + move[1]]
        break if new_move.any? { |num| num.negative? || num > 7 }
        break if piece_in_path(new_move) == false

        potential_moves << new_move
        return true if new_move == move_to.position
      end
    end
  end
  # rubocop: enable Metrics/AbcSize

  def piece_in_path(new_move)
    incrimented_square = Generic.find_square(new_move, board)
    return false if new_move != move_to.position && incrimented_square.current_piece != ' '
  end

  # rubocop: disable Metrics/AbcSize
  def check_stalemate_moves
    temp_array = potential_moves
    @potential_moves = []
    temp_array.each do |move|
      next if move.any? { |num| num.negative? || num > 7 }

      square = Generic.find_square_index(move, board)
      @potential_moves << move if board[square].current_piece == ' ' || board[square].current_piece.colour != colour 
    end
  end
  # rubocop: enable Metrics/AbcSize
end
