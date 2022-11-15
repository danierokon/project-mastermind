# 12 turns limit
# menu -> generate secret code -> (loop) guess => feedback -> result -> replay?
require_relative 'display.rb'
require_relative 'color.rb'
require_relative 'board.rb'
require_relative 'ai_logic.rb'

PEGS = ["black", "red", "green", "brown", "blue", "magenta", "cyan", "gray"]
class Game
  include Display
  attr_reader :board

  def initialize
    @current_turn = 1
    @code = nil
    @guess = nil
    @board = Board.new
    @ai = Logic.new
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
    return computer_guesser_mode if input == '2'

    puts display_input_warning
    game_setup
  end

  def generate_code
    @code = 4.times.map {PEGS.sample}
    @board.generate_code(@code)
  end

  def gaming
    gaming = true
    generate_code
    puts clues_explained
    while gaming == true
      @board.display_board
      puts how_to_guess
      puts @board.pegs_numbers
      puts gaming_message(@current_turn)
      input = gets.chomp
      input = input_check(input,1)
      # compare @guess vs @code for feedback/result
      prefect_match = check_answer(@guess)
      gaming = delcare_result(prefect_match, @current_turn)
      @current_turn += 1
    end
  end

  # check if input has 0 or 9, if integer, if 4 digit
  def input_check(input, type)
    if input.length == 4 && input.match?(/[1-8]{4}/)
      # puts "input good"
      if type == 1
        @guess = input.split('')
        @guess = replace_number_to_color(@guess)
        @board.add_guesses(@guess, @current_turn)
      end
      if type == 2
        @code = input.split('')
        @code = replace_number_to_color(@code)
        @board.generate_code(@code)
      end
    else
      puts bad_input
      input = gets.chomp
      input_check(input, type)
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
    temp_g = []
    temp_c = []
    @code.each {|ele| temp_c << ele.clone}
    @guess.each {|ele| temp_g << ele.clone}
    @guess.each_with_index do |element, index|
      if @guess[index] == @code[index]
        perfect_match += 1
        temp_c[index].replace('Given clues')
        temp_g[index].replace('Given clues')
      end
    end
    @guess.each_with_index do |element, index|
      @code.each_with_index do |code, c_index|
        if index != c_index && element == code && temp_c.include?(code)
          close_match += 1
          temp_c[c_index].replace('Given clues')
          temp_g[index].replace('Given clues')
        end
      end
    end
    @board.add_clues(perfect_match, close_match, @current_turn)
    perfect_match
  end

  def delcare_result(perfect_match, current_turn)
    # result when turns = 12 or prefect match = 4
    if perfect_match == 4
      puts reveal_code(@board.secret_code.join(" "))
      puts win_message
      return false
    elsif current_turn == 12
      puts reveal_code(@board.secret_code.join(" "))
      puts turn_limit
      return false
    end
    true
  end

  def computer_guesser_mode
    # player enter code -> computer guess
    human_code_maker
    # ai gaming
    gaming = true
    while gaming == true
      @board.display_board
      input_check(@ai.submit_guess(1, @board.feedback), 1) if @current_turn == 1
      input_check(@ai.submit_guess(@current_turn, @board.feedback), 1) unless @current_turn == 1
      # compare @guess vs @code for feedback/result
      prefect_match = check_answer(@guess)
      gaming = delcare_result(prefect_match, @current_turn)
      @current_turn += 1
    end
  end

  def human_code_maker
    puts code_maker_message
    puts @board.pegs_numbers
    input = gets.chomp
    input_check(input, 2)
    puts successful_code_creation
    puts press_to_continue
    gets
  end
end