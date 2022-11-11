# display board on screen
require_relative 'color.rb'
class Board  
  # ⬤ ⓿ ❶ ❷ ❸ ❹ ❺ ❻ ❼ ❽
  @@black = "❶".black
  @@red = "❷".red
  @@green = "❸".green
  @@brown = "❹".brown
  @@blue = "❺".blue
  @@magenta = "❻".magenta
  @@cyan = "❼".cyan
  @@gray = "❽".gray

  COLOR_PEGS = {"black" => @@black,
                "red" => @@red,
                "green" => @@green,
                "brown" => @@brown,
                "blue" => @@blue,
                "magenta" => @@magenta,
                "cyan" => @@cyan,
                "gray" => @@gray}

  def initialize
    @secret_code = Array.new
    @guesses = Array.new(12)
    @feedback = Array.new(12)
  end

  def display_board
    "TEST Secret code: " + @secret_code.join(" ")
  end

  def generate_code(code_array)
    code_array.each do |color|
      if COLOR_PEGS[color]
        @secret_code = @secret_code.push(COLOR_PEGS[color])
      end
    end
    @secret_code
  end

  def pegs_numbers
    "1 = #{@@black}, 2 = #{@@red}, 3 = #{@@green}, 4 = #{@@brown}, 5 = #{@@blue}, 6 = #{@@magenta}, 7 = #{@@cyan}, 8 = #{@@gray}"
  end
end