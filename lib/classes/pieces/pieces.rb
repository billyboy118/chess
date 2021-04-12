# frozen_string_literal: false

# super class for all chess pieces to inherit from
class Pieces
  attr_reader :piece_name, :piece, :player_name, :colour, :moves, :special_moves
  attr_accessor :current_location, :move_from, :move_to, :board, :no_of_moves, :potential_moves, :en_passant_pieces, :counter

  include ChessPieces

  @@passant_eligable = 'No'
  @@counter = 0

  def initialize(name, colour)
    @player_name = name
    @colour = colour
    @piece = get_piece(piece_name, @colour)
    @current_location = nil
    @potential_moves = []
    @move_from = []
    @move_to = []
    @board = []
    @no_of_moves = 0
  end

  def legal_move(game_counter)
    return unless can_move_be_made == true

    @@passant_eligable = 'No' if @@counter == game_counter
    puts @@passant_eligable
    @@counter = game_counter + 1

    # eligable en_passant pieces have been pushed into an array, now i need to figure out how to reset this if the player doesnt decide to use the move
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
      return true if potential_moves.include?(move_to.position)
    end
  end

  def loop_piece
    moves.each do |move|
      new_move = move_from
      8.times do
        new_move = [new_move[0] + move[0], new_move[1] + move[1]]
        break if new_move.any? { |num| num.negative? || num > 7 }
        break if piece_in_path(new_move) == false
        return true if new_move == move_to.position
      end
    end
  end

  def piece_in_path(new_move)
    incrimented_square = Generic.find_square(new_move, board)
    puts "this is insquare #{incrimented_square.current_piece}"
    return false if new_move != move_to.position && incrimented_square.current_piece != ' '
  end
end
