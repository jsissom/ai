class AlphaBetaPlayer
  attr_accessor :evaluations

  def initialize(my_letter)
    @my_letter = my_letter
    @evaluations = 0
  end

  def name
    'AlphaBeta'
  end

  MoveScore = Struct.new(:move,:score)

  def make_move(game,level)
    @evaluations = 0
    alpha = -1.0/0.0
    beta = +1.0/0.0
    move,score = max_score(game,level,alpha,beta)
    move
  end

  def max_score(game,level,alpha,beta)
    best_square = nil
    best_score = -1000

    game.empty_squares.each do |sq|
      temp = game.copy_with_move(sq,me)
      if temp.over?
        move_score = score(temp,level+1)
      else
        move,move_score = min_score(temp,level+1,alpha,beta)

        alpha = move_score if move_score > alpha
        return [move,alpha] if alpha >= beta
      end

      if move_score > best_score
        best_square = sq
        best_score = move_score
      end
      # puts "#{game.print_one_line}\t#{sq+1}\t#{move_score}\t#{me}\t#{level}"
    end
    [best_square,best_score]
  end
  
  def min_score(game,level,alpha,beta)
    best_square = nil
    best_score = 1000

    game.empty_squares.each do |sq|
      temp = game.copy_with_move(sq,other_player)
      if temp.over?
        move_score = score(temp,level+1)
      else
        move,move_score = max_score(temp,level+1,alpha,beta)

        beta = move_score if move_score < beta
        return [move,beta] if alpha >= beta
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
    @evaluations += 1
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
