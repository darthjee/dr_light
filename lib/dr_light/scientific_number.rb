# frozen_string_literal: true

module DrLight
  class ScientificNumber
    attr_reader :value, :deviance

    def initialize(value, deviance = 0)
      @value = value
      @deviance = deviance

      @formatted_deviance = deviance.abs
      @exponential = 0
      @significant = 1
    end

    def to_s
      format_value

      format(
        format_string,
        value: formatted_value, exponential: exponential,
        deviance: formatted_deviance
      )
    end

    private

    attr_reader :exponential, :significant,
                :formatted_value, :formatted_deviance

    def format_string
      ["%<value>.#{significant}f"].tap do |values|
        values << '(%<deviance>d)' unless deviance.zero?
        values << 'e%<exponential>d' unless exponential.zero?
      end.join
    end

    def format_value
      return if @formatted_value

      @formatted_value = value.abs

      normalize_value
      normalize_deviance

      @formatted_value *= -1 if value.negative?
      @formatted_value
    end

    def normalize_value
      order = order_from(@formatted_value)
      @exponential += order
      @formatted_value /= (10.0**order)
      @formatted_deviance /= (10.0**order)
    end

    def normalize_deviance
      return if @formatted_deviance.zero?

      if order_difference.negative?
        @formatted_deviance /= (10.0**order_difference)
        @significant -= order_difference
      else
        @formatted_value /= (10.0**order_difference)
        @formatted_deviance /= (10.0**order_difference)
        @exponential += order_difference
      end

      @formatted_deviance = @formatted_deviance * 10 + 0.5
    end

    def order_from(number)
      format('%<number>e', number: number).gsub(/.*e/, '').to_i
    end

    def order_difference
      @order_difference ||=
        order_from(@formatted_deviance) - order_from(@formatted_value)
    end
  end
end
