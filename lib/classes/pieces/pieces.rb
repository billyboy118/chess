# frozen_string_literal: false

# super class for all chess pieces to inherit from
class Pieces
  attr_reader :piece_name, :piece, :player_name, :colour, :moves, :special_moves, :potential_moves
  attr_accessor :current_location, :move_from, :move_to, :board

  include ChessPieces

  def initialize(name, colour)
    @player_name = name
    @colour = colour
    @piece = get_piece(piece_name, @colour)
    @current_location = nil
    @potential_moves = []
    @move_from = []
    @move_to = []
    @board = []
  end

  def legal_move
    calculate_positions
    can_move_be_made
  end

  def calculate_positions
    moves.each do |move|
      new_move = [move_from[0] + move[0], move_from[1] + move[1]]
      potential_moves.push(new_move)
    end
    puts "potential omves #{potential_moves}"
  end

  def can_move_be_made
    if potential_moves.include?(move_to.position)
      puts 'indeed ir is true'
    end
  end
end
