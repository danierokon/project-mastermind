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
    "You can make #{turns} more guess(es)"
  end

  def how_to_guess
    "Enter your input with numbers representing the colored pegs."
  end
end
