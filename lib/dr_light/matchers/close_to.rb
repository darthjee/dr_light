module DrLight
  module Matchers
    class CloseTo < RSpec::Matchers::BuiltIn::BaseMatcher
      def initialize(expected)
        @expected = expected
      end

      def matches?(actual)
      end

      private

      attr_reader :expected
    end
  end
end
