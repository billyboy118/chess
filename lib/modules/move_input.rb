# frozen_string_literal: false

# this module looks at the player input and validates/provides a figure array which can be used
module PlayerInput
  NUMBERS = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7 }.freeze
  
  def input_intro(num)
    show_board
    next_turn(current_player)
    Instructions.short_instructions if counter < 3
    next_turn(current_player)
    position(num)
  end

  def position(num = 'go')
    puts 'Hit Enter for more options'.red
    case num
    when 1 then print 'Which piece would you like to select?: '
    when 2 then print 'Where would you like to move this piece to?: '
    else
      print "Where would you like to #{string}?: "
    end
    response = gets.chomp
    response == '' ? additional_options(num) : convert(response)
  end

  def additional_options(num)
    prompt = TTY::Prompt.new
    greeting = puts "\nWhat would you like to do?"
    choices = ['Restart Turn', 'Concede (not currently available)', 'View Instructions']
    prompt.select(greeting, choices)
    input_intro(num)
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
    find_square(arr)
  end

end
