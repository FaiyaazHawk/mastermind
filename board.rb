# frozen_string_literal: true

# class to display board, method to convert code to colored peg
class Board
  @@peg = "\u25cf"
  @@hint_peg = "\u29bf"
  def self.show_board(guess, turn, hint)
    puts "Guess #{turn} | #{convert_to_peg(guess[0])} #{convert_to_peg(guess[1])} #{convert_to_peg(guess[2])} #{convert_to_peg(guess[3])} | Hint: #{hint[0]} #{hint[1]} #{hint[2]} #{hint[3]}"
  end

  def self.peg
    @@peg
  end

  def self.hint_peg
    @@hint_peg
  end

  def self.convert_to_peg(str)
    case str
    when 'green'
      "\e[32m#{@@peg}\e[0m"
    when 'blue'
      "\e[34m#{@@peg}\e[0m"
    when 'yellow'
      "\e[33m#{@@peg}\e[0m"
    when 'magenta'
      "\e[35m#{@@peg}\e[0m"
    when 'cyan'
      "\e[36m#{@@peg}\e[0m"
    when 'grey'
      "\e[37m#{@@peg}\e[0m"
    else
      'Incorrect color'
    end
  end
end
