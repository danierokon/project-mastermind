# displaying on screen message

module Display
  def display_intro
    'Hello, would you like play a game of Mastermind? (y/n)'
  end

  def display_goodbye
    "Alright, goodbye!"
  end

  def display_input_warning
    "Please enter valid input!"
  end

  def display_setup_message
    "Would you be the codebreaker or the codemaker?"
  end

  def display_setup_choice
    "1. Codebreaker\n2. Codemaker"
  end
end