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
    stuck_in_menu = true
    while stuck_in_menu == true
      if input == 'y'
        stuck_in_menu = false
      elsif input == 'n'
        puts display_goodbye
        return stuck_in_menu = false
      else
        puts display_input_warning
        input = gets.chomp.downcase
      end
    end
    game_setup
  end

  def game_setup
    puts display_setup_message
    puts display_setup_choice
    input = gets.chomp
    stuck_in_menu = true
    while stuck_in_menu
      if input == '1'
        stuck_in_menu = false
        generate_code
        gaming
      elsif input == '2'
        stuck_in_menu = false
        # human input code
      else
        puts display_input_warning
        input = gets.chomp
      end
    end
  end

  def generate_code
    @code = PEGS.sample(4)
    @board.generate_code(@code)
  end

  def gaming
    gaming = true
    while gaming == true
      puts @board.display_board
      puts how_to_guess
      puts @board.pegs_numbers
      puts gaming_message(@turns_left)
      input = gets.chomp
      input = input_check(input)
      sleep 10000
      @turns_left -= 1
      # guess
    end
  end

  #check if input has 0 or 9, if integer, if 4 digit
  def input_check(input)
    if zero_or_nine?(input.split('')) == false && input.to_i != 0 && input.split('').length == 4      
      puts "input good"
    else
      puts "input bad, reeeee"
      input = gets.chomp
      input_check(input)
    end      
  end

  def zero_or_nine?(input_array)
    input_array.reduce do |invalid, digit|
      if %w[0 9].include? digit
        return invalid = true
      else
        invalid = false
      end
    end
  end


end