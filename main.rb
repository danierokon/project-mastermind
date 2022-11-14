require_relative 'game.rb'
require_relative 'display.rb'
require_relative 'board.rb'
require_relative 'color.rb'

include Display
def play_game
  new_game = Game.new
  new_game.menu
  puts thank_you_message
  replay
end

def replay
  input = gets.chomp.downcase
  return play_game if input == 'y'
  return puts display_goodbye if input == 'n'

  puts display_input_warning
  replay
end
# puts "⬤".red
# puts Board::COLOR_PEGS
play_game