# frozen_string_literal: true

module DrLight
  class ScientificNumber
    # @author darthjee
    # @api public
    #
    # Class responsible for normalizing the scientific number
    class Normalizer
      attr_reader :exponential, :significant,
                  :value, :deviance

      # @param value [Numeric] number to be normalized
      # @param deviance [Numeric] deviance of number
      def initialize(value:, deviance:)
        @value = value
        @deviance = deviance
        @significant = 1
        @exponential = 0
        normalize_value
        normalize_deviance
      end

      private

      def normalize_value
        @exponential += value_order
        @value /= value_order_multiplier
        @deviance /= value_order_multiplier
      end

      def normalize_difference
        if order_difference.negative?
          @value *= order_difference_multiplier
          @exponential -= order_difference
        else
          @significant += order_difference
        end
      end

      def normalize_deviance
        return if @deviance.zero?

        normalize_difference
        @deviance *= 10 * order_difference_multiplier
        @deviance += 0.5
      end

      def order_difference
        @order_difference ||= Utils.order_difference(@value, @deviance)
      end

      def order_difference_multiplier
        @order_difference_multiplier ||= 10.0**order_difference
      end

      def value_order
        @value_order ||= Utils.order(@value)
      end

      def value_order_multiplier
        @value_order_multiplier ||= 10.0**value_order
      end
    end
  end
end
