# frozen_string_literal: false

# module to visually display the board
module ShowBoard
  def setup_board
    assign_white
    assign_black
    show_board
  end

  def assign_white
    board[0].current_piece = Rook.new(player1.name, player1.colour)
    board[1].current_piece = Knight.new(player1.name, player1.colour)
    board[2].current_piece = Bishop.new(player1.name, player1.colour)
    board[3].current_piece = Queen.new(player1.name, player1.colour)
    board[4].current_piece = King.new(player1.name, player1.colour)
    board[5].current_piece = Bishop.new(player1.name, player1.colour)
    board[6].current_piece = Knight.new(player1.name, player1.colour)
    board[7].current_piece = Rook.new(player1.name, player1.colour)
    (8..15).each do |i|
      board[i].current_piece = Pawn.new(player1.name, player1.colour)
    end
  end

  def assign_black
    board[56].current_piece = Rook.new(player2.name, player2.colour)
    board[57].current_piece = Knight.new(player2.name, player2.colour)
    board[58].current_piece = Bishop.new(player2.name, player2.colour)
    board[59].current_piece = Queen.new(player2.name, player2.colour)
    board[60].current_piece = King.new(player2.name, player2.colour)
    board[61].current_piece = Bishop.new(player2.name, player2.colour)
    board[62].current_piece = Knight.new(player2.name, player2.colour)
    board[63].current_piece = Rook.new(player2.name, player2.colour)
    (48..55).each do |i|
      board[i].current_piece = Pawn.new(player2.name, player2.colour)
    end
  end

  def show_board
    StartText.welcome_message
    puts ''
    print '   8 '
    (56..63).each do |i|
      if board[i].current_piece == ' '
        print "|#{board[i].current_piece}"
      else
        print "|#{board[i].current_piece.piece}"
      end
    end
    print '|'
    puts ''
    print '   7 '
    (48..55).each do |i|
      if board[i].current_piece == ' '
        print "|#{board[i].current_piece}"
      else
        print "|#{board[i].current_piece.piece}"
      end
    end
    print '|'
    puts ''
    print '   6 '
    (40..47).each do |i|
      if board[i].current_piece == ' '
        print "|#{board[i].current_piece}"
      else
        print "|#{board[i].current_piece.piece}"
      end
    end
    print '|'
    puts ''
    print '   5 '
    (32..39).each do |i|
      if board[i].current_piece == ' '
        print "|#{board[i].current_piece}"
      else
        print "|#{board[i].current_piece.piece}"
      end
    end
    print '|'
    puts ''
    print '   4 '
    (24..31).each do |i|
      if board[i].current_piece == ' '
        print "|#{board[i].current_piece}"
      else
        print "|#{board[i].current_piece.piece}"
      end
    end
    print '|'
    puts ''
    print '   3 '
    (16..23).each do |i|
      if board[i].current_piece == ' '
        print "|#{board[i].current_piece}"
      else
        print "|#{board[i].current_piece.piece}"
      end
    end
    print '|'
    puts ''
    print '   2 '
    (8..15).each do |i|
      if board[i].current_piece == ' '
        print "|#{board[i].current_piece}"
      else
        print "|#{board[i].current_piece.piece}"
      end
    end
    print '|'
    puts ''
    print '   1 '
    (0..7).each do |i|
      if board[i].current_piece == ' '
        print "|#{board[i].current_piece}"
      else
        print "|#{board[i].current_piece.piece}"
      end
    end
    print '|'
    puts ''
    print '      A B C D E F G H'
    puts ''
    puts ''
  end
end
