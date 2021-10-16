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
        while @player.turn <= 12 do
            player_input
            if @player.guess == @computer.guess
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
        for i in 0..player.size do
            for j in 0..computer.size do
                if player[i] == computer[j] && i == j #both index and code match
                    hint[i] = Board.hint_peg.white
                elsif player [i] == computer[j] && i != j #code match but not index
                    hint[i] = Board.hint_peg.red
                else next
                end
            end
        end

        @hint = hint

        
    end

    def conclusion
        if @player.guess == @computer.guess
            create_hint
            Board.show_board(@player.guess,@player.turn,@hint)
            puts "Congrats!! You win!"
        else
            puts "Awww,you didn't get it"
        end
        puts "Do you want to play again? Y or N"
        choice = gets.chomp
        if choice == "Y" || choice == "y"
            play_game
        else
            puts "Thanks for playing"
        end
        
    end








end

start = Game.new
start.play_game


