# frozen_string_literal: true

module DrLight
  class ScientificNumber
    attr_reader :value, :deviance

    def initialize(value, deviance = 0)
      @value = value
      @deviance = deviance
    end

    def to_s
      format('%.2ge%d', formatted_value, exponential)
    end

    private

    attr_reader :exponential

    def formatted_value
      @formatted_value || format_value
    end

    def format_value
      @formatted_value = value.abs
      @exponential = 0

      while @formatted_value > 10
        @formatted_value /= 10.0
        @exponential += 1
      end

      while @formatted_value < 1
        @formatted_value *= 10.0
        @exponential -= 1
      end

      @formatted_value *= -1 if value.negative?
      @formatted_value
    end
  end
end
