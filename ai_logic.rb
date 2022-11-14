# require_relative 'game.rb'
# AI logic for cracking the code
require_relative 'board.rb'
class Logic
  
  def initialize
    @possible_guess_list = [*1..8].repeated_permutation(4).to_a
    @feedback_list = []
  end

  def narrow_guesses(perfect_match, close_match)
    @possible_guess_list.each do |guess|
      @possible_guess_list.list.each do |code|
        # compare guess vs code
        # each guess should have a list of "clues" vs all codes, S
      end
    end
  end
  

  def submit_guess(current_turn, feedback_array)
    if current_turn == 1
      # return '1122'
      '1122'
    else 
      # narrow_guesses
      feedback_array.each_with_index do |feedback, index|
        if !@feedback_list[index] && feedback != nil
          @feedback_list[index] = feedback.clone
        end        
      end
      puts @feedback_list
      "HOLD UP"
    end
  end
end