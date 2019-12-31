# frozen_string_literal: true

module DrLight
  module Matchers
    class CloseTo < RSpec::Matchers::BuiltIn::BaseMatcher
      def initialize(expected, deviance)
        @expected = if expected.is_a?(ScientificNumber)
                      expected
                    else
                      ScientificNumber.new(expected, deviance)
                    end
      end

      def matches?(actual)
        @actual = actual

        distance <= 1.0
      end

      def description
        "be close to #{expected}"
      end

      def failure_message_for_should
        "expected #{actual} to be close to #{expected} but " \
          "was #{distance} deviances far away"
      end

      def failure_message_for_should_not
        "expected #{actual} not to be close to #{expected} " \
          "but was only #{distance} deviances far away"
      end

      alias failure_message failure_message_for_should
      alias failure_message_when_negated failure_message_for_should_not

      private

      attr_reader :expected, :actual

      def distance
        @distance ||= expected.deviance_distance(actual)
      end
    end
  end
end
