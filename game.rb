#main game play to collect all classes into
require './display.rb'
require './player.rb'
require './code_generator.rb'
require './board.rb'

class Game
    include Display
    
    

    CODES = ["green", "blue", "yellow", "magenta", "cyan", "grey"].freeze

    def initialize
        @player = Player.new
        @computer = Player.new
        @hint = []
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
            if @player.guess.all? { |code| @computer.guess.include?(code) } #checking if the player guessed correct
                break
            else
                create_hint
                Board.show_board(@player.guess,@player.turn,@hint)
                @player.turn += 1
            end
        end
    end

    def player_input
        puts "Please enter your guess from the following 'green', 'blue', 'yellow', 'magenta', 'cyan', 'grey' \nYour guess should be entered as the each color separated with a space. \nEx. 'green blue yellow magenta"
        @player.guess = gets.chomp.downcase.split() 
        if @player.guess.all?{|x| CODES.include?(x)} #checking if player guess is valid guess
            
        else
            puts "Error detected. Spelling matters"
            @player.guess = gets.chomp.downcase.split()
        end 
    end

    def create_hint()
        player = @player.guess
        computer = @computer.guess
        hint = Array.new(4)
        for i in player do
            for j in computer do
                if i == j && player.index(i) == computer.index(j) #both code and index match
                    hint[player.index(i)] = Board.hint_peg.white
                elsif i == j && player.index(i) != computer.index(j) # code matches but index doesnt
                    hint[player.index(i)] = Board.hint_peg.red
                else
                    hint[player.index(i)] = "_" #neither code nor index matches
                end
            end
        end

        @hint = hint

        
    end

    








end

test = Game.new
p test
p test.computer_select
test.player_input
p test.create_hint
p test


