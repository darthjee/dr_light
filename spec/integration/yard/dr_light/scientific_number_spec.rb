# frozen_string_literal: true

require 'spec_helper'

describe DrLight::ScientificNumber do
  describe '#to_s' do
    subject(:number) { described_class.new(value, deviance) }

    let(:value)    { 0.42 }
    let(:deviance) { 0.01 }

    it do
      expect(number.to_s).to eq('4.20(10)e-1')
    end
  end
end
