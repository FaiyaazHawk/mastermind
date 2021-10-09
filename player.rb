#player class to keep track of guesses, turn count
class Player
    attr_accessor :guess, :turn

    def initialize()
        @guess = []
        @turn = 1
    end
end

