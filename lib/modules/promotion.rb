# frozen_string_literal: false

# this module if used for the  en passant move
module Promotion

  # First promotion method to determine if piece is a Pawn and they have reached the end
  def verify_promotion
    return unless piece_name == 'Pawn'
    return unless move_to.position[1].zero? || move_to.position[1] == 7

    show_board
    select_promotion_player
  end

  def select_promotion_player
    if player_name == 'Computer'
      piece = %w[Queen Kinght Bishop Rook].sample
      assign_piece(piece)
    else
      select_new_piece
    end
  end

  # first stage
  def select_new_piece
    prompt = TTY::Prompt.new
    greeting = puts "\nWhat would you like to promote your piece to?"
    choices = %w[Queen Knight Bishop Rook]
    response = prompt.select(greeting, choices)
    assign_piece(response)
  end

  # second stage
  def assign_piece(new_piece)
    current_location = Generic.find_square_index(move_to.position, board)
    board[current_location].current_piece = create_piece(new_piece)
  end

  # third stage
  def create_piece(new_piece)
    case new_piece
    when 'Queen'
      Queen.new(player_name, colour, game)
    when 'Knight'
      Knight.new(player_name, colour, game)
    when 'Bishop'
      Bishop.new(player_name, colour, game)
    when 'Rook'
      Rook.new(player_name, colour, game)
    end
  end
end
