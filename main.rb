require_relative 'game.rb'
require_relative 'display.rb'

def play_game
  new_game = Game.new
  new_game.menu
end

play_game