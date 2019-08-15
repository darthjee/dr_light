# frozen_string_literal: true

require 'spec_helper'

describe DrLight::ScientificNumber do
  subject(:number) { described_class.new(value, deviance) }

  describe '#to_s' do
    context 'when there is no deviance' do
      subject(:number) { described_class.new(value) }

      context 'when number only has 2 digits' do
        let(:value) { 12 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2e1')
        end
      end

      context 'when number has more digits' do
        let(:value) { 123 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2e2')
        end
      end
    end
  end
end
