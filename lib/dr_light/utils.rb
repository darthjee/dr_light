# frozen_string_literal: true

module DrLight
  # @author darthjee
  # @api public
  #
  # Module with utility functions
  module Utils
    # Return the order of the number
    #
    # Number 63 can be rewriten as 6.3*10^1 where
    # 1 is the order
    #
    # @param number [Numeric] number to be analyzed
    #
    # @return [Integer]
    def self.order(number)
      format('%<number>e', number: number).gsub(/.*e/, '').to_i
    end

    # Returns the order difference between 2 numbers
    #
    # @param first_number [Numeric] number to be analiyzed
    # @param second_number [Numeric] number to be analiyzed
    #
    # @return [Integer]
    def self.order_difference(first_number, second_number)
      order(first_number) - order(second_number)
    end
  end
end
