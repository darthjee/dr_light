# frozen_string_literal: true

require 'spec_helper'

describe DrLight::ScientificNumber do
  subject(:number) { described_class.new(value, deviance) }

  describe '#to_s' do
    context 'when there is no deviance' do
      subject(:number) { described_class.new(value) }

      context 'when positive number only has 2 digits and order 10' do
        let(:value) { 12 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2e1')
        end
      end

      context 'when positive number has 3 digits and order 10^2' do
        let(:value) { 123 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2e2')
        end
      end

      context 'when positive number only has 2 digits and order 1' do
        let(:value) { 1.2 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2')
        end
      end

      context 'when positive number has 3 digits and order 1' do
        let(:value) { 1.23 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2')
        end
      end
      context 'when positive number only has 2 digits and order 10^-1' do
        let(:value) { 0.12 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2e-1')
        end
      end

      context 'when positive number has 3 digits and order 10^-1' do
        let(:value) { 0.123 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2e-1')
        end
      end
    end
  end
end
