# frozen_string_literal: false

# this module looks at the player input and validates/provides a figure array which can be used
module PlayerInput
  NUMBERS = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7 }.freeze

  def self.position(string='go')
    print "Where would you like to #{string}?: "
    convert(gets.chomp)
  end

  def self.convert(str)
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

  def self.validate_input(str)
    str = str.join('').downcase
    if /[1-8][a-h]|[a-h][1-8]/.match(str)
      assign_value(str.split(''))
    else
      puts 'You have input the incorrect characters, please only input A-H and 1-8'
      position
    end
  end

  def self.assign_value(arr)
    /[1-8]/.match(arr[0]) ? arr.reverse! : arr
    puts arr
    arr[0] = NUMBERS[arr[0]]
    arr[1] = arr[1].to_i - 1
    arr
  end
end
