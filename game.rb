# frozen_string_literal: true

require './player'

class Game #:nodoc:
  private

  attr_reader :first_player, :second_player
  attr_accessor :board_arr, :played_arr

  def initialize
    @first_player = Player.whos_on_first
    @second_player = Player.whats_on_second
    @board_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @played_arr = []
    @ln = '---+---+---'
    @possible_scenerios = []
    @winner = false
    @game_board = refresh_gameboard
    start_up
  end

  def start_up
    puts 'This is your game board.  Each number represents a position for Tic-Tac-Toe.'
    print_status
    round
  end

  def refresh_gameboard
    " #{@board_arr[0]} | #{@board_arr[1]} | #{@board_arr[2]}
    #{@ln}
    #{@board_arr[3]} | #{@board_arr[4]} | #{@board_arr[5]}
    #{@ln}
    #{@board_arr[6]} | #{@board_arr[7]} | #{@board_arr[8]} ".lines.map { |str| str.strip.center(20)}.join("\n")
  end

  def print_status
    puts 'The current game board is'
    puts @game_board
  end

  def round
    # binding.pry
    half_round(first_player) if check_for_winner
    half_round(second_player) if check_for_winner
    round if check_for_winner
  end

  def check_for_winner
    @winner == false
  end

  def half_round(player)
    puts "#{player.name} please select a number to place your #{player.symbol}"
    player_selection = make_selection
    update_board(player_selection, player.symbol)
    scenerios_array = update_scenerios
    check_game_status(scenerios_array, player.name, player.symbol)
  end

  def make_selection
    selection = gets.chomp.to_i
    return play_again if selection==0
    return err_invalid_selection unless (1..9).to_a.include?(selection)
    return err_allready_played if played_arr.include?(selection)

    selection
  end

  def err_invalid_selection
    puts 'Invalid selection. Please enter a number 1 thru 9'
    make_selection
  end

  def err_allready_played
    puts 'That space has already been played. Please make another selection.'
    make_selection
  end

  def update_board(num, current_symbol)
    board_arr[num - 1] = current_symbol
    played_arr << num
    @game_board = refresh_gameboard
    print_status
  end

  def update_scenerios
    @possible_scenerios = [[@board_arr[0], @board_arr[1], @board_arr[2]],
                           [@board_arr[3], @board_arr[4], @board_arr[5]],
                           [@board_arr[6], @board_arr[7], @board_arr[8]],
                           [@board_arr[0], @board_arr[3], @board_arr[6]],
                           [@board_arr[1], @board_arr[4], @board_arr[7]],
                           [@board_arr[2], @board_arr[5], @board_arr[8]],
                           [@board_arr[0], @board_arr[4], @board_arr[8]],
                           [@board_arr[2], @board_arr[4], @board_arr[6]]]
  end

  def check_game_status(arr, name, symbol)
    if arr.map{ |array| array.all? { |s| s == symbol } }.include?(true)
      puts "#{name} is the Winner!"
      @winner = true
      play_again
    elsif played_arr.length == 9
      puts 'Game over!  It\'s a tie.'
      @winner = true
      play_again
    end
  end

  def play_again
    puts 'Would you like to play again? (Y/N)'
    again = gets.chomp
    if %w[Y y].include?(again)
      reset
      Game.new
    else
      puts 'Thanks for playing.'
      exit
    end
  end

  def reset
    @board_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @played_arr = []
    @winner = false
  end
end
