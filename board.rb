#class to display board, method to convert code to colored peg
class Board
    @@peg = "\u25cf"
    @@hint_peg = "\u29bf"
    def self.show_board(guess,turn,hint)
        puts "Guess #{turn} | #{guess[0]} #{guess[1]} #{guess[2]} #{guess[3]} | Hint: #{hint[0]} #{hint[1]} #{hint[2]} #{hint[3]}"
    end

    def self.peg
        @@peg
    end

    def self.hint_peg
        @@hint_peg
    end
    

end

test = Board.new

test.show_board(5,5,5)