# frozen_string_literal: false

# this module looks at the player input and validates/provides a figure array which can be used
module ValidatePieceSelection
  def validate_piece
    return if current_player.selected_grid == 1

    current_piece = current_player.selected_grid.current_piece
    if current_piece == ' '
      @game_message = "You have selected an empty square on the board, please try again\n\n"
    elsif current_piece.colour != @current_player.colour
      @game_message = "That is the other players piece, please try again\n\n"
    else
      correct_piece(current_piece)
    end
  end

  def correct_piece(current_piece)
    @game_message = "You have selected the #{current_piece.piece_name} at #{current_piece.current_location}\n\n"
    current_player.selected_piece = current_piece
    true
  end

  def validate_move
    return true if game_phase == 1

    return if friendly_piece == true

    assign_piece_variables
    if current_player.selected_piece.legal_move(counter) == true
      make_move
    else
      @game_message = 'This is an illegal move'
    end
  end

  def friendly_piece
    return if current_player.selected_move.current_piece == ' ' || current_player.selected_grid.current_piece == ' '
    return unless current_player.selected_move.current_piece.colour == @current_player.colour

    @game_message = 'That is your own piece, please move to another position or restart your turn'
    @game_phase = 3
    true
  end

  def assign_piece_variables
    selected_piece = current_player.selected_piece
    selected_piece.move_from = current_player.selected_grid.position
    selected_piece.move_to = current_player.selected_move
    selected_piece.board = board
  end

  def make_move
    current_player.selected_piece.no_of_moves += 1
    return true if en_passant_make_move == true

    current_player.selected_move.current_piece = current_player.selected_piece
    current_player.selected_grid.current_piece = ' '
    true
  end

  # this method look at the pawn and determines if it is an en passant move, this is needed as this move is the only 
  # move where the player can take a piece without landing directly on the oponents square
  def en_passant_make_move
    piece = current_player.selected_piece

    # hello = piece.no_of_moves - 1
    puts "yes- #{current_player.selected_grid.current_piece}"
    return unless piece.piece_name == 'Pawn'
    return if piece.en_passant_move.nil?

    piece.pawn_move
    # true
  end
end
