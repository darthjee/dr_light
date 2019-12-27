# frozen_string_literal: true

module DrLight
  class ScientificNumber
    # @author darthjee
    # @api private
    #
    # Class responsible for normalizing the scientific number
    class Normalizer
      attr_reader :exponential, :significant, :value, :deviance
      # @method exponential
      # @api private
      #
      # Exponential factor of number
      #
      # Any number can be represented by the exponencial
      # format.
      #
      # ex: +12.4+ can be represented +1.24e1+
      #
      # @return [Numeric]

      # @method significant
      # @api private
      #
      # Significant decimals to be shown from the value
      #
      # The smaller the {#deviance}, more significant
      # digits need to be shown
      #
      # @return [Numeric]

      # @method value
      # @api private
      #
      # The value after normalization
      #
      # Value will be returned always being a value
      # between -10 and 10
      #
      # @return [Numeric]

      # @method deviance
      # @api private
      #
      # Deviance representation
      #
      # Deviance will always be a number
      # between 10 and and 100
      #
      # @return [Integer]

      # @param value [Numeric] number to be normalized
      # @param deviance [Numeric] deviance of number
      def initialize(value:, deviance:)
        @value = value
        @deviance = deviance
        @significant = 1
        normalize_value
        normalize_deviance
      end

      private

      # @private
      #
      # Normalize the value to use scientific notation
      #
      # 612 becomes 6.13
      #
      # 0.613 becomes 6.13
      #
      # The difference is recorded on exponential
      #
      # @return [Numeric] the exponential
      def normalize_value
        @value /= value_order_multiplier
        @deviance /= value_order_multiplier
        @exponential = value_order
      end

      # @private
      #
      # Normalize the values based on the order difference
      #
      # @return [Numeric]
      def normalize_difference
        if order_difference.negative?
          @value *= order_difference_multiplier
          @exponential -= order_difference
        else
          @significant += order_difference
        end
      end

      # @private
      #
      # Normalize the deviance to have 12 digits
      #
      # @return [Numeric]
      def normalize_deviance
        return if @deviance.zero?

        normalize_difference
        @deviance *= 10 * order_difference_multiplier
        @deviance += 0.5
      end

      # @private
      #
      # Order difference  between value and deviance
      #
      # @return [Numeric]
      def order_difference
        @order_difference ||= Utils.order_difference(@value, @deviance)
      end

      # @private
      #
      # potency of 10^order_difference
      #
      # @return [Numeric]
      def order_difference_multiplier
        @order_difference_multiplier ||= 10.0**order_difference
      end

      # @private
      #
      # Order of the value
      #
      # @return [Numeric]
      def value_order
        @value_order ||= Utils.order(@value)
      end

      # @private
      #
      # potency of 10^value_order
      #
      # @return [Numeric]
      def value_order_multiplier
        @value_order_multiplier ||= 10.0**value_order
      end
    end
  end
end
