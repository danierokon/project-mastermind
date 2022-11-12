# 12 turns limit
# menu -> generate secret code -> (loop) guess => feedback -> result -> replay?
require_relative 'display.rb'
require_relative 'color.rb'
require_relative 'board.rb'

PEGS = ["black", "red", "green", "brown", "blue", "magenta", "cyan", "gray"]
class Game
  include Display
  attr_reader :board

  def initialize
    @turns_left = 12
    @code = nil
    @guess = nil
    @board = Board.new
  end

  def menu
    puts display_intro
    input = gets.chomp.downcase
    return game_setup if input == 'y'
    return puts display_goodbye if input == 'n'

    puts display_input_warning
    menu
  end

  def game_setup
    puts display_setup_message
    puts display_setup_choice
    input = gets.chomp
    return gaming if input == '1'
    return puts "human input code" if input == '2'

    puts display_input_warning
    game_setup
  end

  def generate_code
    @code = PEGS.sample(4)
    @board.generate_code(@code)
  end

  def gaming
    gaming = true
    generate_code
    while gaming == true
      puts @board.display_board
      puts how_to_guess
      puts @board.pegs_numbers
      puts gaming_message(@turns_left)
      input = gets.chomp
      input = input_check(input)
      # compare @guess vs @code for feedback/result

      @turns_left -= 1
    end
  end

  #check if input has 0 or 9, if integer, if 4 digit
  def input_check(input)
    if input.length == 4 && input.match?(/[1-8]{4}/)
      puts "input good"
      @guess = input.split('')
      @guess = replace_number_to_color(@guess)
      puts @guess
    else
      puts "input bad, reeeee"
      input = gets.chomp
      input_check(input)
    end
  end
  
  def replace_number_to_color(guess_array)
    guess_array.map do |element|
      case element
      when '1'
        element = "black"
      when '2'
        element = "red"
      when '3'
        element = "green"
      when '4'
        element = "brown"
      when '5'
        element = "blue"
      when '6'
        element = "magenta"
      when '7'
        element = "cyan"
      when '8'
        element = "gray"
      end
    end
  end

  def check_answer(guess)
    # match = 4 => win
    # match .each + .each -> @guess[0] == @code[0] = match+1, @guess[0] == @code[not 0] = close+1 ???
  end
end