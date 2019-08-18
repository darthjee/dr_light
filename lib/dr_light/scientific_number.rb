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
        value: formatted_value, exponential: exponential, deviance: formatted_deviance * 10 + 0.5
      )
    end

    private

    attr_reader :exponential, :formatted_value, :formatted_deviance, :significant

    def format_string
      ["%<value>.#{significant}f"].tap do |values|
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

      o = order(@formatted_value)
      @exponential += o
      @formatted_value /= (10.0**o)
      @formatted_deviance /= (10.0**o)

      unless @formatted_deviance.zero?
        if order_difference < 0
          @formatted_deviance /= (10.0 ** order_difference)
          @significant -= order_difference
        else
          @formatted_value /= (10.0 ** order_difference)
          @formatted_deviance /= (10.0 ** order_difference)
          @exponential += order_difference
        end
      end

      @formatted_value *= -1 if value.negative?
      @formatted_value
    end
    # rubocop:enable Metrics/MethodLength:

    def order(number)
      format('%e', number).gsub(/.*e/, '').to_i
    end

    def order_difference
      @order_difeference ||= order(@formatted_deviance) - order(@formatted_value)
    end
  end
end
