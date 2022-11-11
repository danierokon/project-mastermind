# display board on screen
require_relative 'color.rb'
class Board
  COLOR_PEGS = ["⬤".black, "⬤".red, "⬤".green, "⬤".brown,
                "⬤".blue, "⬤".magenta, "⬤".cyan, "⬤".gray]

  def initialize
    @secret_code = nil
    @guesses = Array.new(12)
    @feedback = Array.new(12)
  end

  def display_board

  end

  def generate_code
    
  end
end