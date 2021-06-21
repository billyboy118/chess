# frozen_string_literal: false

# this module is for the check and chackmate methods
module SaveLoad
  def save_game
    p 'hello save'
    create_file
    position
  end

  def create_file
    puts 'What would you like to save your game as?'
    save_name = gets.chomp
    # File.open("#{save_name}.txt", 'w') do |file|
    #  file.write to_json
    # end
    File.open("#{save_name}.yml", 'w') { |file| YAML.dump([] << self, file) }
  end

  def self.select_loaded_file
    return puts "\nNo games to load".red if Dir.glob('*.yml').length.zero?

    prompt = TTY::Prompt.new
    greeting = 'Which game would you like to load?'
    choices = Dir.glob('*.yml')
    response = prompt.select(greeting, choices)
    load_game(response)
  end

  # def to_json
  #  board = @board[1].current_piece
  #  p self
  #  JSON.dump({
  #    board: board_to_json,
  #    counter: @counter,
  #    player1: @player1,
  #    player2: @player2,
  #    current_player: @current_player,
  #    game_message: @game_message,
  #    game_phase: @game_phase
  # })
  # end

  # def board_to_json
  #   board = []
  #   @board.each do |square|
  #     board.push(square)
  #     board.push(position: square.position)
  #     board.push(current_piece: square.current_piece)
  #   end
  #   board
  # end
end
