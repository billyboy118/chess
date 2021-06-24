# frozen_string_literal: false

# this module navigates the player input and manages the in game options menu
module NavigateGame
  # this method is called from the board class and is what initiates this navigate game cycle when the board class calls
  # this method game_phase == 1
  def player_input
    while game_phase < 5
      return if grid_select_loop == 'Yes'
      return if move_to == 'Yes'
    end
  end

  def grid_select_loop
    while game_phase < 3
      grid_select_intro if game_phase == 1
      grid_select if game_phase == 2
      return 'Yes' if @concede == 'Yes'
    end
  end

  def grid_select_intro
    current_player.selected_grid = input_intro
    @concede = current_player.selected_grid
    return if @concede == 'Yes'

    @game_phase = 2
    validate_piece
  end

  def grid_select
    loop do
      break if validate_piece == true

      current_player.selected_grid = select_piece_retry
      @concede = 'Yes' if current_player.selected_move == 'Yes'
      return 'Yes' if @concede == 'Yes'
    end
    @game_phase = 3 if game_phase != 1
  end

  def move_to
    loop do
      current_player.selected_move = select_piece_retry
      @concede = 'Yes' if current_player.selected_move == 'Yes'
      return 'Yes' if concede == 'Yes'
      break if validate_move == true
    end
    @game_phase = 5 if game_phase != 1
  end
end
