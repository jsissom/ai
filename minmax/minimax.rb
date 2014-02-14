class MiniMaxPlayer
  attr_accessor :evals

  def initialize(my_letter)
    @my_letter = my_letter
    @evals = 0
  end

  def name
    'MiniMax'
  end

  MoveScore = Struct.new(:move,:score)

  def make_move(game,level)
    move,score = max_score(game,level)
    move
  end

  def max_score(game,level)
   @evals += 1
    best_square = nil
    best_score = -1000

    game.empty_squares.each do |sq|
      temp = game.copy_with_move(sq,me)
      if temp.over?
        move_score = score(temp,level+1)
      else
        move,move_score = min_score(temp,level+1)
      end

      if move_score > best_score
        best_square = sq
        best_score = move_score
      end
      # puts "#{game.print_one_line}\t#{sq+1}\t#{move_score}\t#{me}\t#{level}"
    end
    [best_square,best_score]
  end
  
  def min_score(game,level)
    @evals += 1
    best_square = nil
    best_score = 1000

    game.empty_squares.each do |sq|
      temp = game.copy_with_move(sq,other_player)
      if temp.over?
        move_score = score(temp,level+1)
      else
        move,move_score = max_score(temp,level+1)
      end

      if move_score < best_score
        best_square = sq
        best_score = move_score
      end
      # puts "#{game.print_one_line}\t#{sq+1}\t#{move_score}\t#{other_player(me)}\t#{level}"
    end
    [best_square,best_score]
  end

  # board - board to evaluate
  # move - Move in game (level in tree)
  #
  # This will return a positive number if we
  # have won, negative if other has won
  # 0 if no one won or tie
  def score(board,level)
    return (10 - level) if board.win?(me)
    return 0 - (10 - level) if board.win?(other_player)

    return 0
  end

  def me
    @my_letter
  end

  def other_player
    (me == :x) ? :o : :x
  end
end
