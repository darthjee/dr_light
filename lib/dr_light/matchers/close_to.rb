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

        expected.deviance_distance(actual) <= 1.0
      end

      private

      attr_reader :expected, :actual
    end
  end
end
