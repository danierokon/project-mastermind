# display board on screen
require_relative 'color'
class Board
  # ⬤ ⦿ ⓿ ❶ ❷ ❸ ❹ ❺ ❻ ❼ ❽
  attr_reader :secret_code, :feedback

  @@black = '❶'.black
  @@red = '❷'.red
  @@green = '❸'.green
  @@brown = '❹'.brown
  @@blue = '❺'.blue
  @@magenta = '❻'.magenta
  @@cyan = '❼'.cyan
  @@gray = '❽'.gray

  COLOR_PEGS = { 'black' => @@black,
                 'red' => @@red,
                 'green' => @@green,
                 'brown' => @@brown,
                 'blue' => @@blue,
                 'magenta' => @@magenta } # "cyan" => @@cyan,
  # "gray" => @@gray

  def initialize
    @secret_code = []
    @guesses = Array.new(12)
    @feedback = Array.new(12)
  end

  def display_board
    # puts "TEST Secret code: " + @secret_code.join(" ")
    @guesses.each_with_index do |guess, index|
      puts "#{index + 1}.  #{guess.join(' ')}    #{@feedback[index]}" unless guess.nil?
    end
  end

  def generate_code(code_array)
    code_array.each do |color|
      @secret_code = @secret_code.push(COLOR_PEGS[color]) if COLOR_PEGS[color]
    end
    @secret_code
  end

  def pegs_numbers
    "1 = #{@@black}, 2 = #{@@red}, 3 = #{@@green}, 4 = #{@@brown}, 5 = #{@@blue}, 6 = #{@@magenta}" # , 7 = #{@@cyan}, 8 = #{@@gray}
  end

  def add_guesses(guess_array, current_turn)
    @guesses[current_turn - 1] = guess_array.dup
    @guesses[current_turn - 1].each_with_index do |color, index|
      @guesses[current_turn - 1][index] = COLOR_PEGS[color] if COLOR_PEGS[color]
    end
  end

  def add_clues(perfect_match, close_match, current_turn)
    @feedback[current_turn - 1] = '' if @feedback[current_turn - 1].nil?
    perfect_match.times do
      @feedback[current_turn - 1].concat('⬤ '.red)
    end
    close_match.times do
      @feedback[current_turn - 1].concat('⦿ '.red)
    end
    (4 - perfect_match - close_match).times do
      @feedback[current_turn - 1].concat('⬤ '.gray)
    end
  end
end
