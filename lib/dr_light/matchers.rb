# frozen_string_literal: true

module DrLight
  # @api public
  #
  # Rspec matchers DSL to be included in rspec
  #
  # @example
  #   RSpec.configure do |config|
  #     config.include DrLight::Matchers
  #   end
  module Matchers
    autoload :CloseTo, 'dr_light/matchers/close_to'

    # Checks if value is close to expected value
    #
    # @overload be_close_to(expected, deviance: nil)
    #   @param expected [Number] Target to be close to
    #   @param deviance [Number] Closeness deviance
    #
    # @overload be_close_to(expected)
    #   @param expected [ScientificNumber] target to be close to
    #
    # @return [CloseTo]
    #
    # @example
    #   describe DrLight::Matchers do
    #     describe 'be_close_to' do
    #       subject(:value) { 10.0 }
    #
    #       context 'when they are close' do
    #         it do
    #           expect(value).to be_close_to(11, deviance: 1)
    #         end
    #       end
    #
    #       context 'when they are not close' do
    #         let(:expected) { DrLight::ScientificNumber.new(9, 0.5) }
    #
    #         it do
    #           expect(value).not_to be_close_to(expected)
    #         end
    #       end
    #     end
    #   end
    def be_close_to(expected, deviance: nil)
      CloseTo.new(expected, deviance)
    end
  end
end
