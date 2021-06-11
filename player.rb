# frozen_string_literal: true

class Player #:nodoc:
  attr_reader :name, :symbol

  protected

  @@players = []
  @@used_symbols = []
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @first = @symbol == 'X'
    Player.players << self
  end

  def self.find_symbol
    entry = gets.chomp.upcase
    unless %w[X O].include?(entry)
      puts 'That selection is invalid.  Please select the letter X or O.'
      entry = find_symbol
    end
    entry
  end

  def self.setup_players(int)
    puts "Enter a name for player #{int + 1}."
    temp_name = gets.chomp
    if Player.used_symbols.empty?
      puts "Welcome #{temp_name}. Would you like to be X's or O's (Please enter x or o. X's go first)"
      temp_symbol = Player.find_symbol
      Player.used_symbols << temp_symbol
    else
      temp_symbol = Player.used_symbols.include?('X') ? 'O' : 'X'
    end
    Player.new(temp_name, temp_symbol)
  end

  class << self
    def whos_on_first
      Player.players.find { |plyr| plyr.instance_variable_get(:@first) }
    end

    def whats_on_second
      Player.players.find { |plyr| !plyr.instance_variable_get(:@first) }
    end

    def players
      @@players
    end

    def used_symbols
      @@used_symbols
    end
  end
end
