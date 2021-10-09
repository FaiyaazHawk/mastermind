#main game play to collect all classes into
require './display.rb'
require './player.rb'
require './code_generator.rb'

class Game
    include Display

    CODES = ["green", "blue", "yellow", "magenta", "cyan", "grey"].freeze

    def initialize
        @player = Player.new
        @computer = Player.new
    end

    def play_game
        introduction
        computer_select
        player_guesses #limited to 12 turns
        conclusion
    end

    def introduction
        puts welcome
        puts game_explanation
    end
    
    def computer_select
        @computer.guess = Code_generator.generate_code
    end

    def player_guesses
        while @player.turn < 13 do
            player_input
            if @player.guess == @computer.guess
                break
            else
                create_hint
                show_board
                @player.turn += 1
            end
        end
    end

    def player_input
        puts "Please enter your guess. \nYour guess should be entered as the each color separated with a space. \nEx. 'green blue yellow magenta"
        @player.guess = gets.chomp.downcase.split() #regex for the 6 specific colors?? 
        
    end
end

test = Game.new
p test
p test.player_input
p test
