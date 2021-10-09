#select random code from 6 colors

class Code_generator
    attr_reader :generate_code

CODES = ["green", "blue", "yellow", "magenta", "cyan", "grey"].freeze

    def self.generate_code
        return Array.new(CODES.sample(4)) #picks 4 random colors from array
    end
end

