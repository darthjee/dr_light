# frozen_string_literal: true

module DrLight
  module Matchers
    # @api private
    # @author darthjee
    #
    # Matcher checking that 2 numbers are
    # close to each other
    class CloseTo < RSpec::Matchers::BuiltIn::BaseMatcher
      # @overload initialize(expected, deviance)
      #   @param expected [Number] expected value
      #     to be close to
      #   @param deviance [Number] Proximity deviance
      # @overload initialize(expected)
      #   @param expected [ScientificNumber] expected value
      #     to be close to
      def initialize(expected, deviance)
        @expected = if expected.is_a?(ScientificNumber)
                      expected
                    else
                      ScientificNumber.new(expected, deviance)
                    end
      end

      # returns if actual is close to expected
      #
      # @return [TrueClass,FalseClass]
      def matches?(actual)
        @actual = actual

        distance <= 1.0
      end

      # returns matcher description on success
      #
      # @return [String]
      def description
        "be close to #{expected}"
      end

      # returns message for failure on should
      #
      # @return [String]
      def failure_message_for_should
        "expected #{actual} to be close to #{expected} but " \
          "was #{distance} deviances far away"
      end

      # returns message for failure on should not
      #
      # @return [String]
      def failure_message_for_should_not
        "expected #{actual} not to be close to #{expected} " \
          "but was only #{distance} deviances far away"
      end

      alias failure_message failure_message_for_should
      alias failure_message_when_negated failure_message_for_should_not

      private

      attr_reader :expected, :actual
      # @method expected
      # @api private
      # @private
      #
      # expected value to be close to
      #
      # @return [ScientificNumber]

      # @method actual
      # @api private
      # @private
      #
      # value to be close to expected
      #
      # @return [Number,ScientificNumber]

      # distance in deviances between the 2 numbers
      #
      # @return [Float]
      def distance
        @distance ||= expected.deviance_distance(actual)
      end
    end
  end
end
