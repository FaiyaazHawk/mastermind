# frozen_string_literal: true

# main game play to collect all classes into
require './display'
require './player'
require './code_generator'
require './board'

class Game
  include Display

  CODES = %w[green blue yellow magenta cyan grey].freeze

  def initialize
    @player = Player.new
    @computer = Player.new
    @hint = Array.new(4)
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
    puts 'press 1 to be a BREAKER or 2 to be a MAKER'
    game = gets.chomp
    case game
    when '1'
      code_breaker
    when '2'
      code_maker
    else
      puts 'Input error'
      game = gets.chomp
    end
  end

  def code_breaker
    puts game_explanation
    computer_select
    player_guesses # limited to 12 turns
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
    while @player.turn <= 12
      player_input
      if @player.guess == @computer.guess
        break
      else
        create_hint
        Board.show_board(@player.guess, @player.turn, @hint)
        @player.turn += 1
      end
    end
    create_hint
    Board.show_board(@player.guess, @player.turn, @hint)
  end

  def computer_guesses
    guesses = %w[green blue yellow magenta cyan grey]
    solution = Array.new(4)
    while solution != @player.guess && @computer.turn < 13
      puts 'Thinking...'
      sleep(1.5)
      guess = guesses.pop
      @computer.guess = Array.new(4, guess)
      create_hint_computer
      Board.show_board(@computer.guess, @computer.turn, @hint)
      @computer.turn += 1
      if @hint.include?(Board.hint_peg.white)
        solution[@hint.index(Board.hint_peg.white)] = guess
      end
    end
    @computer.guess = solution
    create_hint_computer
    puts 'I think I got it...'
    sleep(1.5)
    Board.show_board(@computer.guess, @computer.turn, @hint)
  end

  def player_input
    puts "Please enter your code from the following 'green', 'blue', 'yellow', 'magenta', 'cyan', 'grey' \nYour code should be entered as the each color separated with a space. \nEx. 'green blue yellow magenta"
    @player.guess = gets.chomp.downcase.split
    if @player.guess.all? { |x| CODES.include?(x) } # checking if player guess is valid guess

    else
      puts 'Error detected. Spelling matters'
      @player.guess = gets.chomp.downcase.split
    end
  end

  def create_hint
    player = @player.guess
    computer = @computer.guess
    hint = Array.new(4)
    (0..player.size).each do |i|
      (0..computer.size).each do |j|
        if player[i] == computer[j] && i == j # both index and code match
          hint[i] = Board.hint_peg.white
        elsif player [i] == computer[j] && i != j # code match but not index
          hint[i] = Board.hint_peg.red
        else
          next
        end
      end
    end

    @hint = hint
  end

  def create_hint_computer
    player = @player.guess
    computer = @computer.guess
    hint = Array.new(4)
    (0..computer.size).each do |i|
      (0..player.size - 1).each do |j|
        if computer[i] == player[j] && i == j # both index and code match
          hint[i] = Board.hint_peg.white
        elsif computer [i] == player[j] && i != j # code match but not index
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

      puts 'The code was broken!'
    else
      puts 'The code was not broken!'
    end
    puts 'Do you want to play again? Y or N'
    choice = gets.chomp
    if %w[Y y].include?(choice)
      play_game
    else
      puts 'Thanks for playing'
    end
  end
end

start = Game.new
start.play_game
