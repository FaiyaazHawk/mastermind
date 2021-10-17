#module to display messages
require './color.rb'
module Display

    @@peg = "\u25cf"
    @@hint_peg = "\u29bf"

    def welcome
        puts "Hi there, Lets play Mastermind"
    end

    def game_options
        puts "You can either be a code MAKER or code BREAKER"
    end

    def game_explanation
        <<~HEREDOC
            This is a 1 player game against the computer.
            In this iteration, the computer will select a random 4 color disks(no duplicates) from the following 6 color disks
            #{@@peg.green} #{@@peg.blue} #{@@peg.yellow} #{@@peg.magenta} #{@@peg.cyan} #{@@peg.grey}
            You're job is to figure out this secret 4 disk combo within 12 turns
            
            To help you out, after each guess, the computer will provide a hint as to the accuracy of the guess.
            
            If a guessed color is in the code but in the wrong position, the hint section will display a #{@@hint_peg.red}
            If a guessed color is in the code and in the correct position, the hint section will display a #{@@hint_peg.white}
            If a guessed color is not in the code, the hint will remain blank (eg: _)
            
        HEREDOC
    end
end

