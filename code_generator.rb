# frozen_string_literal: true

# select random code from 6 colors

class Code_generator
  attr_reader :generate_code

  CODES = %w[green blue yellow magenta cyan grey].freeze

  def self.generate_code
    Array.new(CODES.sample(4)) # picks 4 random colors from array
  end
end
