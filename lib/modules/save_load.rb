# frozen_string_literal: false

# this module is for the check and chackmate methods
module SaveLoad
  def save_game
    create_file
    position
  end

  def create_file
    puts 'What would you like to save your game as?'
    save_name = gets.chomp
    File.open("#{save_name}.yml", 'w') { |file| YAML.dump([] << self, file) }

    puts "\n Game Saved".green
  end

  def self.select_loaded_file
    return puts "\nNo games to load".red if Dir.glob('*.yml').length.zero?

    prompt = TTY::Prompt.new
    greeting = 'Which game would you like to load?'
    choices = Dir.glob('*.yml')
    response = prompt.select(greeting, choices)
    load_game(response)
  end

  # rubocop: disable Metrics/AbcSize
  def self.load_game(file_name)
    loaded_file = YAML.load_file(file_name)
    loaded_game = Board.new(nil, nil)

    loaded_game.board = loaded_file[0].board
    loaded_game.counter = loaded_file[0].counter
    loaded_game.player1 = loaded_file[0].player1
    loaded_game.player2 = loaded_file[0].player2
    loaded_game.current_player = loaded_file[0].current_player
    loaded_game.game_message = loaded_file[0].game_message
    loaded_game.game_phase = loaded_file[0].game_phase

    loaded_game.game_cycle
  end
  # rubocop: enable Metrics/AbcSize
end
