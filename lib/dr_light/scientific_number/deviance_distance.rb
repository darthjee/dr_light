# frozen_string_literal: true

module DrLight
  class ScientificNumber
    class DevianceDistance
      def initialize(number, other)
        @number = number

        @other = if other.is_a?(ScientificNumber)
                   other
                 else
                   ScientificNumber.new(other)
                 end
      end

      def to_f
        return 0 if difference.zero?

        difference.abs / deviance
      end

      private

      attr_reader :number, :other

      def difference
        @difference ||= other.value - number.value
      end

      def deviance
        @deviance ||= Math.sqrt(
          number.deviance**2 + other.deviance**2
        )
      end
    end
  end
end
