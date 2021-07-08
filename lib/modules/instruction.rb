# frozen_string_literal: false

# module to start the game off
module Instructions
  def self.short_instructions
    puts "\nInstruction to move a piece:".green
    puts '1. Select your piece using the grid coordinates, e.g. a2.'.green
    puts '2. Select the coordinates where you want to move your piece to.'.green
    puts '3. If you select a piece and then change your mind, you can restart by hitting enter.'.green
    puts "\n- The game will only allow you to make legal chess moves.".green
    puts '- Unique moves such as castling and en-passant are applied.'.green
    puts '- Hit enter at any point during the game to bring up the options menu.'.green

    instruction_prompt
  end

  def self.instruction_prompt
    prompt = TTY::Prompt.new
    greeting = puts "\nAre you happy or would you like further instructions on how to play chess?"
    choices = ["No, I don't need the instructions", 'Yes, I would like further instructions']
    full_instruction if prompt.select(greeting, choices).include? 'Yes'
  end

  # rubocop: disable Metrics/MethodLength
  def self.full_instruction
    puts "\nThe King".green
    puts <<~HEREDOC
      The king is the most important piece because you lose the game when he is attacked and can't get to safety. This is called checkmate, and it is how a game is decided.

      The King can move just one square at a time.

      When your king is threatened by being placed in check, you must remove the threat. A king can move one square in any direction (except it moves two squares when castling, which is discussed as a special move below), but it cannot move into check or next to the enemy king. It can capture any enemy piece except the king. Because of its weakness, the king rarely plays an active role until the endgame.
    HEREDOC
    puts "\nThe Queen".green
    puts <<~HEREDOC
      The queen is the most powerful piece because it can move in any straight-line direction: vertically, horizontally, or diagonally. It also can move any number of squares.

      The queen can control 27 squares from the center.

      Although you start with only one queen, you may gain another one when a pawn promotes (see special moves below). Because the queen is slightly stronger than a rook and bishop together, exchanging the queen for a single piece other than the enemy queen is usually not a good idea.
    HEREDOC
    puts "\nThe Rook".green
    puts <<~HEREDOC
      You have two rooks; each one starts on a corner square. It may move vertically or horizontally through any unoccupied square. 

      The rook controls 14 squares from the center.

      It participates with the king in a special move called castling. A major piece, the rook is stronger than a bishop or knight. Rooks are very powerful in the endgame when they can control many squares and move without being blocked by pawns.
    HEREDOC
    puts "\nThe Bishop"
    puts <<~HEREDOC
      You also start with two bishops, one on a light square and one on a dark square. Like a rook, a bishop may move through any unoccupied square, but each one moves only diagonally.

      The bishop controls 13 squares from the center.

      Because it always stays on the same color, it has access to only half of the squares on the board.
    HEREDOC
    puts "\nThe Knight"
    puts <<~HEREDOC
      Unlike other pieces, the knight moves in two directions at once. This tricky piece moves in an "L"-shaped pattern (two squares in one direction and then one square in a different direction).

      From its square, the knight can control up to eight squares.

      In the center of the board, it can dangerously attack many squares and is well-suited for a tactic known as a fork. Although a minor piece, the knight is useful in “closed” games when many pieces clutter the board because it alone has the special ability to jump over any piece.
    HEREDOC
    puts "\nThe Pawn".green
    puts <<~HEREDOC
      Each player begins with eight pawns, each one in a line in front of the other pieces.

      The game starts with 16 pawns, eight white and eight black.

      Until a pawn advances across the board to the final rank when it can be promoted, it is the weakest piece in most situations, but it can be valuable to block enemy pieces. Unlike other pieces, a pawn moves only forward unless it is capturing an enemy piece, which it does by moving diagonally one square to the left or right. It moves only one square except on its first move when it may move one or two squares forward. A surprising move of the pawn is the en passant.


      Instructions taken from: https://www.chesskid.com/how-to-play-chess
    HEREDOC
  end
  # rubocop: enable Metrics/MethodLength
end
