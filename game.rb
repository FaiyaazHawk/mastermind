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
        game_select
        conclusion
    end

    def introduction
        puts welcome
        puts game_options
    end

    def game_select
        puts "press 1 to be a BREAKER or 2 to be a MAKER"
        game = gets.chomp
        if game == "1"
            code_breaker
        elsif game == "2"
            code_maker
        else
            puts "Input error"
            game = gets.chomp
        end
    end

    def code_breaker
        puts game_explanation
        computer_select
        player_guesses #limited to 12 turns
    end

    def code_maker
        puts breaker_explanation
        player_input
        computer_guesses
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

    def computer_guesses
        while @computer.turn <= 12 do
            computer_turn
            if @player.guess == @computer.guess
                break
            else
                create_hint
                Board.show_board(@computer.guess,@computer.turn,@hint)
                @computer.turn += 1
            end
        end
        
    end

    def player_input
        puts "Please enter your code from the following 'green', 'blue', 'yellow', 'magenta', 'cyan', 'grey' \nYour code should be entered as the each color separated with a space. \nEx. 'green blue yellow magenta"
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
                else 
                    next
                end
            end
        end

        @hint = hint

        
    end

    def conclusion
        if @player.guess == @computer.guess
            create_hint
            Board.show_board(@player.guess,@player.turn,@hint)
            puts "The code was broken!"
        else
            puts "The code was not broken!"
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


