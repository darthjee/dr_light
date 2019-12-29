# frozen_string_literal: true

module DrLight
  # @author darthjee
  # @api public
  #
  # Number to be exibed in scientific number
  class ScientificNumber
    autoload :DevianceDistance,
             'dr_light/scientific_number/deviance_distance'

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
    def initialize(value, deviance = nil)
      @value    = value.to_f
      @deviance = deviance.to_f
    end

    # string representation of number
    #
    # @example
    #   number = DrLight::ScientificNumber.new(0.42, 0.01)
    #   number.to_s # returns '4.20(10)e-1'
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

    # Calculates the distance to another number in deviances
    #
    # the deviance will be a composition of both numbers
    # deviances
    #
    # @see DevianceDistance
    #
    # @return [Float] always positive number
    def deviance_distance(other)
      DevianceDistance.new(self, other).to_f
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
