# displaying on screen message
require_relative 'color.rb'

module Display
  def display_intro
    'Hello, would you like play a game of Mastermind? (y/n)'
  end

  def display_goodbye
    "Alright, goodbye!"
  end

  def display_input_warning
    "Please enter valid input!".red
  end

  def display_setup_message
    "Would you be the codebreaker or the codemaker?"
  end

  def display_setup_choice
    "1. Codebreaker\n2. Codemaker"
  end

  def gaming_message(turns)
    return "This is your last chance, think carefully!" if turns == 12
    "You can make #{13 - turns} more guesses"
  end

  def how_to_guess
    "Enter your input with numbers representing the colored pegs."
  end

  def bad_input
    "Makes sure your input is just 4 numbers(1-8) (dupes allowed)".red
  end

  def win_message
    "You've cracked the code! Congratualations!"
  end

  def turn_limit
    "Unfortunately, you've ran out of chances, better luck next time!"
  end

  def reveal_code(code)
    "The secret code is #{code} "
  end

  def thank_you_message
    "Thank you for playing! Another game maybe?(y/n)"
  end
end
