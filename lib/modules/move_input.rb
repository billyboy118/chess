# frozen_string_literal: false

# this module looks at the player input and validates/provides a figure array which can be used
module PlayerInput
  NUMBERS = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7 }.freeze

  def input_intro
    show_board("#{current_player.name} it is your turn!")
    insert_computer_move
    Instructions.short_instructions if counter < 3 && game_phase == 1
    position
  end

  def insert_computer_move
    return unless player2.name == 'Computer' && !player2.selected_grid.nil?

    player2_piece = player2.selected_piece
    puts "\nThe computer moved their #{player2_piece.piece_name} from #{Generic.raw_to_string(player2.selected_grid.position)} to #{player2_piece.current_location}".green
  end

  def select_piece_retry
    show_board("#{current_player.name} it is your turn!")
    puts "\n#{game_message.yellow}"
    @game_message = ''
    position
  end

  def position
    puts 'You are in check' if start_turn_identify_check == true
    puts "\nHit Enter for more options\n".red
    case game_phase
    when 1..2 then print 'Which piece would you like to select?: '
    when 3..4 then print "\n#{game_message.yellow}Where would you like to move this piece to?: "
    else
      print 'Where would you like to go?: '
    end
    response = gets.chomp.gsub(/[^A-Za-z0-9\s]/i, '')
    response == '' ? additional_options : convert(response)
  end

  def additional_options
    prompt = TTY::Prompt.new
    greeting = puts "\nWhat would you like to do?"
    choices = ['Resume', 'Restart Turn', 'Concede', 'View Instructions', 'Save Game', 'Exit Game']
    response = prompt.select(greeting, choices)
    prompt_response(response)
  end

  def prompt_response(response)
    case response
    when 'Resume' then position
    when 'Restart Turn' then @game_phase = 1
    when 'View Instructions'
      Instructions.full_instruction
      position
    when 'Save Game' then save_game
    when 'Exit Game' then Exit
    when 'Concede' then 'Yes'
    end
  end

  def convert(str)
    str = str.split
    str_length = str.length
    if str_length == 2 && str[0].length == 1 && str[1].length == 1
      validate_input(str)
    elsif str_length == 1 && str[0].length == 2
      validate_input(str)
    else
      puts 'You have input the wrong amount of characters, please only input 2'
      position
    end
  end

  def validate_input(str)
    str = str.join('').downcase
    if /[1-8][a-h]|[a-h][1-8]/.match(str)
      assign_value(str.split(''))
    else
      puts 'You have input the incorrect characters, please only input A-H and 1-8'
      position
    end
  end

  def assign_value(arr)
    /[1-8]/.match(arr[0]) ? arr.reverse! : arr
    arr[0] = NUMBERS[arr[0]]
    arr[1] = arr[1].to_i - 1
    Generic.find_square(arr, board)
  end
end
