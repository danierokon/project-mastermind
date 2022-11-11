require_relative 'game.rb'
require_relative 'display.rb'
require_relative 'board.rb'
require_relative 'color.rb'
def play_game
  new_game = Game.new
  new_game.menu
end
# puts "⬤".red
puts Board::COLOR_PEGS
play_game