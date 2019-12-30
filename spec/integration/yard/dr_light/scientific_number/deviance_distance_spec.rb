# frozen_string_literal: true

require 'spec_helper'

describe DrLight::ScientificNumber::DevianceDistance do
  describe '#to_f' do
    describe 'yard' do
      subject(:distance) { described_class.new(number, other) }

      let(:number) { DrLight::ScientificNumber.new(100, 3) }

      context 'with scientific number' do
        let(:other) { DrLight::ScientificNumber.new(110, 4) }

        it 'calculates distance' do
          expect(distance.to_f).to eq(2)
        end
      end

      context 'with number' do
        let(:other) { 91 }

        it 'calculates distance' do
          expect(distance.to_f).to eq(3)
        end
      end
    end
  end
end
