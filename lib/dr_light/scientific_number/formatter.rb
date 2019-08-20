# frozen_string_literal: true

module DrLight
  class ScientificNumber
    # @author darthjee
    # @api public
    #
    # Class responsible for formatting the values of
    # {ScientificNumber}
    class Formatter
      attr_reader :exponential, :significant,
                  :value, :deviance

      # @param value [Nuber] number to be exibed
      # @param deviance [Number] deviance of number
      def initialize(value:, deviance:)
        @value = value
        @deviance = deviance
        @significant = 1
        @exponential = 0
        format_value
      end

      # Returns the string of the format expected for
      # {ScientificNumber#to_s}
      #
      # @return [String]
      def format_string
        ["%<value>.#{significant}f"].tap do |values|
          values << '(%<deviance>d)' unless deviance.zero?
          values << 'e%<exponential>d' unless exponential.zero?
        end.join
      end

      private

      def format_value
        normalize_value
        normalize_deviance
      end

      def normalize_value
        order = order_from(@value)
        @exponential += order
        @value /= (10.0**order)
        @deviance /= (10.0**order)
      end

      def normalize_deviance
        return if @deviance.zero?

        if order_difference.negative?
          @value *= (10.0**order_difference)
          @exponential -= order_difference
        else
          @significant += order_difference
        end

        @deviance *= 10 * (10.0**order_difference)
        @deviance += 0.5
      end

      def order_from(number)
        format('%<number>e', number: number).gsub(/.*e/, '').to_i
      end

      def order_difference
        @order_difference ||=
          order_from(@value) - order_from(@deviance)
      end
    end
  end
end
