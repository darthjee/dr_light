# frozen_string_literal: true

module DrLight
  class ScientificNumber
    # @api private
    #
    # @author Dathjee
    #
    # Class Responsible for calculating distance between 2 numbers
    # in number of deviances
    #
    # The combined deviance of numbers n1(d1), n2(d2)
    # is d = sqrt(d1 ** 2 + d2 ** 2)
    #
    # @example With scientific number
    #   number = DrLight::ScientificNumber.new(100, 3)
    #   other  = DrLight::ScientificNumber.new(110, 4)
    #
    #   distance = DrLight::ScientificNumber::DevianceDistance.new(
    #     number, other
    #   )
    #
    #   distance.to_f    # returns 2
    #
    # @example With scientific number
    #   number = DrLight::ScientificNumber.new(100, 3)
    #   other  = 91
    #
    #   distance = DrLight::ScientificNumber::DevianceDistance.new(
    #     number, other
    #   )
    #
    #   distance.to_f    # returns 3
    class DevianceDistance
      # @param number [ScientificNumber] first number
      # @param other [ScientificNumber,Number] second number
      def initialize(number, other)
        @number = number

        @other = if other.is_a?(ScientificNumber)
                   other
                 else
                   ScientificNumber.new(other)
                 end
      end

      # Calculates the distance of numbers in deviances
      #
      # @return [Float] always positive number
      def to_f
        return 0 if difference.zero?

        difference / deviance
      end

      private

      attr_reader :number, :other
      # @method number
      # @api private
      # @private
      #
      # first number
      #
      # @return [ScientificNumber]

      # @method other
      # @api private
      # @private
      #
      # second_number
      #
      # @return [ScientificNumber]

      # @private
      # Raw difference between two numbers
      #
      # @return [Float] always positive number
      def difference
        @difference ||= (other.value - number.value).abs
      end

      # @privte
      #
      # Combined deviances
      #
      # Combined deviances of n1(d1) and n2(d2)
      # is d = sqrt(d1 ** 2 + d2 ** 2)
      #
      # @return [Float] always positive number
      def deviance
        @deviance ||= Math.sqrt(
          number.deviance**2 + other.deviance**2
        )
      end
    end
  end
end
