# require_relative 'game.rb'
# AI logic for cracking the code
require_relative 'board.rb'
class Logic
  
  def initialize
    @possible_guess_list = [*1..8].repeated_permutation(4).to_a
    @previous_clues = []
  end

  def narrow_guesses(clues = @previous_clues)
    score = to_score
    puts score
    @possible_guess_list.each do |guess|
      @possible_guess_list.list.each do |code|
        # compare guess vs code
        # each guess should have a list of "clues" vs all codes, S
        # if prefect_match close_match == latest feedback
        # update @possible_list
        # keep going with #.sample ?
      end
    end
  end
  

  def submit_guess(current_turn, feedback_array)
    if current_turn == 1
      # return '1122'
      '1122'
    else 
      # narrow_guesses
      @previous_clues = []
      feedback_array.each_with_index do |feedback, index|
        if feedback != nil
          @previous_clues << feedback.clone
        end
      end
      puts @previous_clues
      # narrow_guesses
      "HOLD UP"
    end
  end

  def to_score(clues = @previous_clues)
    clues[0].gsub(/\s+/, '')
    [clues[0].count('⬤'.red), clues[0].count('⦿'.red)]
  end
end