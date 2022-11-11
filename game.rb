# 12 turns limit
# menu -> generate secret code -> (loop) guess => feedback -> result -> replay?
require_relative 'display.rb'

class Game
  include Display

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
        stuck_in_menu = false
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
        # computer generate code
      elsif input == '2'
        stuck_in_menu = false
        # human input code
      else
        puts display_input_warning
        input = gets.chomp
      end
    end
  end


end