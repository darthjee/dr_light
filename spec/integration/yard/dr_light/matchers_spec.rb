# frozen_string_literal: true

require 'spec_helper'

describe DrLight::Matchers do
  describe 'be_close_to' do
    subject(:value) { 10.0 }

    context 'when they are close' do
      it do
        expect(value).to be_close_to(11, deviance: 1)
      end
    end

    context 'when they are not close' do
      let(:expected) { DrLight::ScientificNumber.new(9, 0.5) }

      it do
        expect(value).not_to be_close_to(expected)
      end
    end
  end
end
