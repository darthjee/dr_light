# frozen_string_literal: true

require 'spec_helper'

describe DrLight::ScientificNumber do
  describe '#to_s' do
    describe 'yard' do
      subject(:number) { described_class.new(value, deviance) }

      let(:value)    { 0.42 }
      let(:deviance) { 0.01 }

      it do
        expect(number.to_s).to eq('4.20(10)e-1')
      end
    end
  end

  describe 'deviance_distance' do
    subject(:number) { described_class.new(100, 3) }

    context 'when other is a number' do
      it 'returns the deviance distance' do
        expect(number.deviance_distance(115)).to eq(5)
      end
    end

    context 'when other is a scientific number' do
      let(:other) { described_class.new(115, 4) }

      it 'returns the deviance distance' do
        expect(number.deviance_distance(other)).to eq(3)
      end
    end
  end
end
