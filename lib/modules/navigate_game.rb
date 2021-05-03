# frozen_string_literal: false

# this module navigates the player input and manages the in game options menu
module NavigateGame

  # this method is called from the board class and is what initiates this navigate game cycle when the board class calls
  # this method game_phase == 1
  def player_input
    while game_phase < 5
      grid_select_loop
      move_piece_loop
    end
  end

  def grid_select_loop
    while game_phase < 3
      grid_select_intro if game_phase == 1
      grid_select if game_phase == 2

    end
  end

  def grid_select_intro
    current_player.selected_grid = input_intro
    @game_phase = 2
    validate_piece
  end

  def grid_select
    current_player.selected_grid = select_piece_retry until validate_piece == true
    @game_phase = 3 if game_phase != 1
  end

  # this method is where the player will move the piece to and is invoked by the player_input method 
  def move_piece_loop
    while game_phase > 2 && game_phase < 5
     # move_to_intro if game_phase == 3
      move_to if game_phase == 3
    end
  end

  #def move_to_intro
  #  current_player.selected_move = input_intro
  #  validate_move
  #  @game_phase = 4 if game_phase != 1
  #end

  def move_to
    current_player.selected_move = select_piece_retry 
    current_player.selected_move = select_piece_retry until validate_move == true
    @game_phase = 5 if game_phase != 1
  end
end
