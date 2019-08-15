# frozen_string_literal: true

module DrLight
  class ScientificNumber
    attr_reader :value, :deviance

    def initialize(value, deviance = 0)
      @value = value
      @deviance = deviance
    end

    def to_s
      format_value

      if exponential.zero?
        format('%<value>.2g', value: formatted_value)
      else
        format(
          '%<value>.2ge%<exponential>d',
          value: formatted_value, exponential: exponential
        )
      end
    end

    private

    attr_reader :exponential, :formatted_value

    # rubocop:disable Metrics/MethodLength:
    def format_value
      return if @formatted_value

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
    # rubocop:enable Metrics/MethodLength:
  end
end