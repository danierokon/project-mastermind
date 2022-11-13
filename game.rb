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
    @current_turn = 1
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
      @board.display_board
      puts how_to_guess
      puts @board.pegs_numbers
      puts gaming_message(@current_turn)
      input = gets.chomp
      input = input_check(input)
      # compare @guess vs @code for feedback/result
      prefect_match = check_answer(@guess)
      gaming = delcare_result(prefect_match, @current_turn)
      @current_turn += 1
    end 
    puts "wtf"
  end

  # check if input has 0 or 9, if integer, if 4 digit
  def input_check(input)
    if input.length == 4 && input.match?(/[1-8]{4}/)
      # puts "input good"
      @guess = input.split('')
      @guess = replace_number_to_color(@guess)
      @board.add_guesses(@guess, @current_turn)
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
    perfect_match = 0
    close_match = 0
    color_with_perfect_match = []
    color_with_close_match = []
    @guess.each_with_index do |element, index|
      if @guess[index] == @code[index]
        perfect_match += 1
        color_with_perfect_match << element
      end
    end
    @guess.each_with_index do |element, index|
      next if color_with_perfect_match.include?(element) || color_with_close_match.include?(element)

      close_match += 1 if @code.include?(element)
      color_with_close_match << element if @code.include?(element)
    end
    @board.add_clues(perfect_match, close_match, @current_turn)
    perfect_match
  end

  def delcare_result(perfect_match, current_turn)
    # result when turns = 12 or prefect match = 4
    if perfect_match == 4
      puts "win"
      return false
    elsif current_turn == 12
      puts "no more guesses available"
      return false
    end
    true
  end
end