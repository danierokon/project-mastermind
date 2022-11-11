# 12 turns limit
# menu -> generate secret code -> (loop) guess => feedback -> result -> replay?
require_relative 'display.rb'

class Game
  include Display

  def initialize
    @turns_left = 12
    @code = nil
  end

  def menu
    puts display_intro
    input = gets.chomp.downcase
    stuck_in_menu = true
    while stuck_in_menu == true
      if input == 'y'
        puts "sets rules here"
        stuck_in_menu = false
      elsif input == 'n'
        puts display_goodbye
        stuck_in_menu = false
      else
        puts display_input_warning
        input = gets.chomp.downcase
      end
    end
  end
end