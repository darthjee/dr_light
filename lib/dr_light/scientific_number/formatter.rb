# frozen_string_literal: true

module DrLight
  class ScientificNumber
    # @author darthjee
    # @api private
    #
    # Class responsible for formatting the values of
    # {ScientificNumber}
    class Formatter
      # @param value [Numeric] number to be exibed
      # @param deviance [Numeric] deviance of number
      def initialize(normalizer)
        @normalizer = normalizer
      end

      # Returns the string of the format expected
      #
      # @see ScientificNumber#to_s
      #
      # @return [String]
      def format_string
        ["%<value>.#{normalizer.significant}f"].tap do |values|
          values << '(%<deviance>d)' if deviance?
          values << 'e%<exponential>d' if exponential?
        end.join
      end

      private

      attr_reader :normalizer
      # @method normalizer
      # @private
      # @api private
      #
      # Number normalizer
      #
      # @return [Normalizer]

      # @private
      # @api private
      #
      # Checks if deviance should be present on the output
      #
      # @return [TrueClass,FalseClass]
      def deviance?
        !normalizer.deviance.zero?
      end

      # @private
      # @api private
      #
      # Checks if exponential should be present on the output
      #
      # @return [TrueClass,FalseClass]
      def exponential?
        !normalizer.exponential.zero?
      end
    end
  end
end
