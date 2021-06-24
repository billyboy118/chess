# frozen_string_literal: false

# module to visually display the board
module ShowBoard
  LOCATIONS = { 63 => (56..63), 55 => (48..55), 47 => (40..47), 39 => (32..39), 31 => (24..31), 23 => (16..23), 15 => (8..15), 7 => (0..7)}.freeze
  def setup_board
    assign_white
    assign_black
    assign_locations_to_pieces
    show_board('')
  end

  # rubocop: disable Metrics/AbcSize
  def assign_white
    board[0].current_piece = Rook.new(player1.name, player1.colour, self)
    board[1].current_piece = Knight.new(player1.name, player1.colour, self)
    board[2].current_piece = Bishop.new(player1.name, player1.colour, self)
    board[3].current_piece = Queen.new(player1.name, player1.colour, self)
    board[4].current_piece = King.new(player1.name, player1.colour, self)
    board[5].current_piece = Bishop.new(player1.name, player1.colour, self)
    board[6].current_piece = Knight.new(player1.name, player1.colour, self)
    board[7].current_piece = Rook.new(player1.name, player1.colour, self)
    (8..15).each { |i| board[i].current_piece = Pawn.new(player1.name, player1.colour, self) }
  end

  def assign_black
    board[56].current_piece = Rook.new(player2.name, player2.colour, self)
    board[57].current_piece = Knight.new(player2.name, player2.colour, self)
    board[58].current_piece = Bishop.new(player2.name, player2.colour, self)
    board[59].current_piece = Queen.new(player2.name, player2.colour, self)
    board[60].current_piece = King.new(player2.name, player2.colour, self)
    board[61].current_piece = Bishop.new(player2.name, player2.colour, self)
    board[62].current_piece = Knight.new(player2.name, player2.colour, self)
    board[63].current_piece = Rook.new(player2.name, player2.colour, self)
    (48..55).each { |i| board[i].current_piece = Pawn.new(player2.name, player2.colour, self) }
  end
  # rubocop: enable Metrics/AbcSize

  def assign_locations_to_pieces
    board.each do |square|
      if square.current_piece != ' '
        raw_location = square.position
        square.current_piece.current_location = show_game_location(raw_location)
      end
    end
  end

  def show_game_location(raw_location)
    letters = { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D', 4 => 'E', 5 => 'F', 6 => 'G', 7 => 'H' }
    "#{letters[raw_location[0]]}, #{raw_location[1] + 1}"
  end

  def show_board(name = nil)
    assign_locations_to_pieces
    StartText.welcome_message
    board_line_loop
    puts ''
    puts '               A  B  C  D  E  F  G  H'
    puts ''
    puts ''
    puts name.to_s
  end

  def board_line_loop
    line_counter = 8
    index_counter = 63
    8.times do
      puts ''
      print "            #{line_counter} "
      index_counter = add_pieces_to_board(index_counter, line_counter)

      print ' '
      line_counter -= 1
    end
  end

  # rubocop: disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
  def add_pieces_to_board(counter, line_counter)
    LOCATIONS[counter].each do |i|
      current_piece = board[i].current_piece
      if (line_counter.even? && counter.odd?) || (line_counter.odd? && counter.even?)
        print current_piece == ' ' ? " #{current_piece.on_red} ".on_red : " #{current_piece.piece} ".on_red
      else
        print current_piece == ' ' ? " #{current_piece.on_blue} ".on_blue : " #{current_piece.piece} ".on_blue
      end
      counter -= 1
    end
    counter
  end
  # rubocop: enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
end
