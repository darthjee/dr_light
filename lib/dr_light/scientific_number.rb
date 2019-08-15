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

      format(
        format_string,
        value: formatted_value, exponential: exponential, deviance: formatted_deviance * 10
      )
    end

    private

    attr_reader :exponential, :formatted_value, :formatted_deviance

    def format_string
      if exponential.zero?
        if deviance.zero?
          '%<value>.2g'
        else
          '%<value>.2g(%<deviance>d)'
        end
      else
        if deviance.zero?
          '%<value>.2ge%<exponential>d'
        else
          '%<value>.2g(%<deviance>d)e%<exponential>d'
        end
      end
    end

    # rubocop:disable Metrics/MethodLength:
    def format_value
      return if @formatted_value

      @formatted_value = value.abs
      @formatted_deviance = deviance.abs
      @exponential = 0

      while @formatted_value > 10
        @formatted_value /= 10.0
        @formatted_deviance /= 10.0
        @exponential += 1
      end

      while @formatted_value < 1
        @formatted_value *= 10
        @formatted_deviance *= 10
        @exponential -= 1
      end

      @formatted_value *= -1 if value.negative?
      @formatted_value
    end
    # rubocop:enable Metrics/MethodLength:
  end
end
