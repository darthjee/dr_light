# frozen_string_literal: true

module DrLight
  # @author darthjee
  # @ai public
  #
  # Module with utility functions
  module Utils
    # Return the order of the number
    #
    # Number 63 can be rewriten as 6.3*10^1 where
    # 1 is the order
    #
    # @param number [Numeric]
    # @return [Integer]
    def self.order(number)
      format('%<number>e', number: number).gsub(/.*e/, '').to_i
    end
  end
end
