# frozen_string_literal: false

# module for single player mode
module SinglePlayer
  def self.initate_single_player
    name = player_name
    StartText.welcome_message
    puts "\nHello #{name} lets play some chess!"
    sleep 2
    player1 = Player.new(name, 'White')
    computer = Player.new('Computer', 'Black')
    board = Board.new(player1, computer)
    board.game_cycle
  end

  def self.player_name
    StartText.welcome_message
    puts "\nWhat is your name?"
    while (name = gets.chomp)
      case name
      when 'Computer' then puts 'That name is taken please try again'
      else return name
      end
    end
  end

  def select_computer_move
    @game_phase = 2
    find_computer_piece
    validate_move
  end

  # identifies one of the conmputers pieces
  # rubocop: disable Metrics/AbcSize
  def find_computer_piece
    loop do
      square = board[rand(63)]
      next if square.current_piece == ' ' || square.current_piece.colour == 'White'

      current_player.selected_grid = Generic.find_square(square.position, board)
      current_player.selected_piece = current_player.selected_grid.current_piece
      next if find_legal_move != true

      return
    end
  end

  # identifies a legal move for the piece seleted above
  def find_legal_move
    100.times do
      current_player.selected_piece.potential_moves = []
      num = board[rand(63)]
      comp_piece = num.current_piece
      next if comp_piece != ' ' && comp_piece.colour == 'Black'

      current_player.selected_move = Generic.find_square(num.position, board)
      assign_piece_variables
      next if current_player.selected_piece.legal_move(counter) != true

      return true
    end
  end
  # rubocop: enable Metrics/AbcSize
end
