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
    #
    # @example Negative big number
    #   DrLight::Utils.order(-100) # returns 2
    # @example Positive small number
    #   DrLight::Utils.order(0.01) # returns -2
    # @example Zero
    #   DrLight::Utils.order(0) # returns 0
    def self.order(number)
      format('%<number>e', number: number).gsub(/.*e/, '').to_i
    end

    # Returns the order difference between 2 numbers
    #
    # @param first_number [Numeric] number to be analiyzed
    # @param second_number [Numeric] number to be analiyzed
    #
    # @return [Integer]
    #
    # @example
    #   DrLight::Utils.order_difference(-10, 0.1) # returns 2
    def self.order_difference(first_number, second_number)
      order(first_number) - order(second_number)
    end
  end
end
