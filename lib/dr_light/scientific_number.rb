# frozen_string_literal: true

module DrLight
  # @author darthjee
  # @api public
  #
  # Number to be exibed in scientific number
  class ScientificNumber
    autoload :Formatter,  'dr_light/scientific_number/formatter'
    autoload :Normalizer, 'dr_light/scientific_number/normalizer'

    attr_reader :value, :deviance
    # @!method value
    # @api public
    #
    # The number value (average)
    #
    # @return [Numeric]

    # @!method deviance
    # @api public
    #
    # The deviance from the average (imprecision)
    #
    # @return [Numeric]

    # @param value [Nuber] number to be exibed
    # @param deviance [Number] deviance of number
    def initialize(value, deviance = 0)
      @value = value
      @deviance = deviance
    end

    # string representation of number
    #
    # @return [String]
    def to_s
      format(
        formatter.format_string,
        value: normalizer.value,
        exponential: normalizer.exponential,
        deviance: normalizer.deviance
      )
    end

    private

    # @private
    # @api private
    #
    # String formatter
    #
    # @return [Formatter]
    def formatter
      @formatter ||= Formatter.new(normalizer)
    end

    # @private
    # @api private
    #
    # Values normalizer
    #
    # @return [Normalizer]
    def normalizer
      @normalizer ||= Normalizer.new(
        value: value,
        deviance: deviance
      )
    end
  end
end
