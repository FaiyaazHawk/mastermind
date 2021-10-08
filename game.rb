#main game play to collect all classes into
require './display.rb'
require './player.rb'
require './code_generator.rb'

class Game
    include Display
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
        @computer.guess = Code_generator.new.generate_code
    end
end

test = Game.new
p test.computer_select
p @player
p @computer
