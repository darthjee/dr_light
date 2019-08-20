# frozen_string_literal: true

module DrLight
  # @author darthjee
  # @api public
  #
  # Number to be exibed in scientific number
  class ScientificNumber
    autoload :Formatter, 'dr_light/scientific_number/formatter'
    attr_reader :value, :deviance

    # @param value [Nuber] number to be exibed
    # @param deviance [Number] deviance of number
    def initialize(value, deviance = 0)
      @value = value
      @deviance = deviance
    end

    # string representation of number
    def to_s
      format(
        formatter.format_string,
        value: formatter.value,
        exponential: formatter.exponential,
        deviance: formatter.deviance
      )
    end

    private

    def formatter
      @formatter ||= Formatter.new(
        value: value,
        deviance: deviance
      )
    end
  end
end
