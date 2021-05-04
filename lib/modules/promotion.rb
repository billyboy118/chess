# frozen_string_literal: false

# this module if used for the  en passant move
module Promotion

  # First promotion method to determine if piece is a Pawn and they have reached the end
  def verify_promotion
    return unless piece_name == 'Pawn'
    return unless move_to.position[1].zero? || move_to.position[1] == 7

    show_board
    select_new_piece
  end

  def select_new_piece
    prompt = TTY::Prompt.new
    greeting = puts "\nWhat would you like to promote your piece to?"
    choices = %w[Queen Knight Bishop Rook]
    response = prompt.select(greeting, choices)

  end


end