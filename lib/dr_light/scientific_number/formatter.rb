# frozen_string_literal: true

module DrLight
  class ScientificNumber
    # @author darthjee
    # @api public
    #
    # Class responsible for formatting the values of
    # {ScientificNumber}
    class Formatter
      attr_reader :normalizer

      # @param value [Numeric] number to be exibed
      # @param deviance [Numeric] deviance of number
      def initialize(normalizer)
        @normalizer = normalizer
      end

      # Returns the string of the format expected for
      # {ScientificNumber#to_s}
      #
      # @return [String]
      def format_string
        ["%<value>.#{normalizer.significant}f"].tap do |values|
          values << '(%<deviance>d)' unless normalizer.deviance.zero?
          values << 'e%<exponential>d' unless normalizer.exponential.zero?
        end.join
      end
    end
  end
end
