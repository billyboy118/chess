# frozen_string_literal: false

# this module looks at the player input and validates/provides a figure array which can be used
module ValidatePieceSelection
  def validate_piece
    current_piece = current_player.selected_grid.current_piece
    if current_piece == ' '
      @game_message = "You have selected an empty square on the board, please try again\n\n"
    elsif current_piece.colour != @current_player.colour
      @game_message = "That is the other players piece, please try again\n\n"
    else
      @game_message = "You have selected the #{current_piece.piece_name} at #{current_piece.current_location}\n\n"
      current_player.selected_piece = current_piece
      true
    end
  end

  def validate_move
    current_player.selected_move.current_piece = current_player.selected_piece
    current_player.selected_grid.current_piece = ' '
    true
  end
end
