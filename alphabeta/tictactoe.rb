require 'forwardable'
require_relative 'alphabeta'

# Object to hold the board (no game logic)
class Board
  def initialize
    @board = Array.new(9) { :empty }
  end

  def get(position)
    @board[position]
  end

  def set(position,player)
    @board[position] = player
  end

  def empty?(position)
    @board[position] == :empty
  end

  def empty_squares
    e = []
    (0..8).each do |n|
      e << n if @board[n] == :empty
    end
    e
  end

  def print_one_line
    "#{@board}"
  end

  def print_board
    puts
    print_row(0)
    puts "----------- -----------"
    print_row(3)
    puts "----------- -----------"
    print_row(6)
  end

  def print_row(s)
    puts " #{square_char(s)} | #{square_char(s+1)} | #{square_char(s+2)}   #{s+1} | #{s+2} | #{s+3}"
  end

  def square_char(pos)
    return ' ' if @board[pos] == :empty
    return 'X' if @board[pos] == :x
    return 'O' if @board[pos] == :o
  end
end

# Tic Tac Toe Logic
class TicTacToeGame
  extend Forwardable

  def initialize
    @board = Board.new
  end

  def copy
    t = TicTacToeGame.new
    (0..8).each { |s| t.set(s,get(s)) }
    t
  end

  def copy_with_move(position,player)
    t = copy
    t.set(position,player)
    t
  end

  def_delegators :@board,:get,:set,:empty?,:empty_squares,:print_board,:print_one_line

  def win?(player)
    win_row?(0,player) || win_row?(3,player) || win_row?(6,player) ||
      win_column?(0,player) || win_column?(1,player) || win_column?(2,player) ||
      win_diagonal?(player)
  end

  def over?
    win?(:x) || win?(:o) || tie?
  end

  def tie?
    empty_squares.empty? && (! win?(:x)) && (! win?(:o))
  end

  def win_row?(position,player)
    (get(position) == player) && (get(position+1) == player) && (get(position+2) == player)
  end

  def win_column?(position,player)
    (get(position) == player) && (get(position+3) == player) && (get(position+6) == player)
  end

  def win_diagonal?(player)
    ((get(0) == player) && (get(4) == player) && (get(8) == player)) ||
      ((get(2) == player) && (get(4) == player) && (get(6) == player)) 
  end

  def print_status
    puts "X has won." if win?(:x)
    puts "O has won." if win?(:o)
    puts "Tie." if tie?
  end
end

class HumanPlayer
  def initialize(xoro)
    @xoro = xoro
  end

  def name
    'You'
  end

  def make_move(game,level)
    m = ''
    n = 0
    begin
      print 'Your move: '
      m = STDIN.gets.chomp
      n = m.to_i
    end while (n < 1 || n > 9) || ! game.empty?(n-1)
    n - 1
  end
end

class DumbComputerPlayer
  def initialize(xoro)
    @xoro = xoro
  end

  def name
    'Dummy'
  end

  def make_move(game,xoro,level)
    game.empty_squares[0]
  end
end

class Play
  def initialize
    @t = TicTacToeGame.new
    @x = AlphaBetaPlayer.new(:x)
    @o = HumanPlayer.new(:o)
    @level = 0
  end

  def play_o(position)
    @t.set(position,:o)
    @level += 1
  end

  def play_x(position)
    @t.set(position,:x)
    @level += 1
  end

  def play
    @t.print_board
    @t.print_status
    while ! @t.over? do
      m = @x.make_move(@t,@level)
      play_x(m)
      puts "#{@x.name} played X in square #{m+1}"

      puts "Evaluations: #{@x.evaluations}"

      @t.print_board
      @t.print_status

      if ! @t.over?
        m = @o.make_move(@t,@level)
        play_o(m)
        puts "#{@o.name} played O in square #{m+1}"
        
        @t.print_board
        @t.print_status
      end
    end
  end
end

t = Play.new
t.play
