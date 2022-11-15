# require_relative 'game.rb'
# AI logic for cracking the code
require_relative 'board.rb'
class Logic
  
  def initialize
    @possible_guess_list = [*1..6].repeated_permutation(4).to_a
    @previous_clues = []
    @previous_guess = ''
  end

  # compare guess vs code
  # each guess should have a list of "clues" vs all codes, S
  # if prefect_match close_match == latest feedback
  # update @possible_list
  # keep going with #.sample ?
  # check
  def narrow_guesses
    score = to_score # [perfect_match, close_match]
    perfect_match = score[0]
    close_match = score[1]
    elim_guesses(perfect_match, close_match, @possible_guess_list)
  end
  

  def submit_guess(current_turn, feedback_array)
    if current_turn == 1
      # puts "length of possible code list = #{@possible_guess_list.length}"
      @previous_guess = '1122'.split('').map!{|n| n.to_i}
      '1122'
    else 
      @previous_clues = []
      feedback_array.each_with_index do |feedback, index|
      @previous_clues << feedback.clone if index == current_turn - 2
      end
      narrow_guesses
      # puts "length of possible code list = #{@possible_guess_list.length}"
      @previous_guess = @possible_guess_list.sample
      return @previous_guess.join('')
    end
  end

  def to_score(clues = @previous_clues)
    temp = clues[0].gsub(/\s+/, '')
    [temp.scan('⬤'.red).length, temp.scan('⦿'.red).length]
  end

  def elim_guesses(perfect_match, close_match, list, guess = @previous_guess)
    list.select! do |code|
      pm = 0
      cm = 0
      temp_g = []
      temp_c = []
      perfect_index = [] # code index with perfect match
      code.each {|ele| temp_c << ele.clone}
      guess.each {|ele| temp_g << ele.clone}
      guess.each_with_index do |element, index|
        if guess[index] == code[index]
          pm += 1
          temp_c[index] = ('Given clues')
          temp_g[index] = ('Given clues')
          perfect_index << index.clone
        end
      end
      guess.each_with_index do |element, index|
        code.each_with_index do |code, c_index|
          if index != c_index && element == code && temp_c.include?(code) && temp_g.include?(element) && !perfect_index.include?(c_index)
            cm += 1
            temp_c[c_index] = ('Given clues')
            temp_g[index] = ('Given clues')
          end
        end
      end
      true if pm == perfect_match && cm == close_match
    end
  end
end