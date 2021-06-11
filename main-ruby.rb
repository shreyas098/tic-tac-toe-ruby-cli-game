#!/usr/bin/env ruby
# frozen_string_literal: true

require './player'
require './game'

puts "Hi, Let\'s play Tic-Tac-Toe in the console."

2.times { |i| Player.setup_players(i) }

Game.new
