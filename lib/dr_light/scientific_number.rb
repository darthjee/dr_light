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

    attr_reader :exponential, :formatted_value, :formatted_deviance, :significant

    def format_string
      [ "%<value>.#{significant}f" ].tap do |values|
        values << '(%<deviance>d)' unless deviance.zero?
        values << 'e%<exponential>d' unless exponential.zero?
      end.join
    end

    # rubocop:disable Metrics/MethodLength:
    def format_value
      return if @formatted_value

      @formatted_value = value.abs
      @formatted_deviance = deviance.abs
      @exponential = 0
      @significant = 1

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

      unless @formatted_deviance.zero?
        while @formatted_deviance < 1
          @formatted_deviance *= 10
          @significant += 1
        end
      end

      @formatted_value *= -1 if value.negative?
      @formatted_value
    end
    # rubocop:enable Metrics/MethodLength:
  end
end
