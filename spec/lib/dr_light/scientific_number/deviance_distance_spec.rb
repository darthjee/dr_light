# frozen_string_literal: true

require 'spec_helper'

describe DrLight::ScientificNumber::DevianceDistance do
  subject(:distance) { described_class.new(number, other) }

  let(:value)    { 120 }
  let(:deviance) { 10 }
  let(:number) do
    DrLight::ScientificNumber.new(value, deviance)
  end

  describe 'to_f' do
    context 'when passing a number' do
      context 'when passing a number smaller, but within 1 deviance' do
        let(:other) { 111 }

        it do
          expect(distance.to_f).to be_positive
        end

        it 'returns deviance distance' do
          expect(distance.to_f).to eq(0.9)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:other) { 139 }

        it do
          expect(distance.to_f).to be_positive
        end

        it 'returns deviance distance' do
          expect(distance.to_f).to eq(1.9)
        end
      end

      context 'when passing a number equal' do
        let(:other) { 120 }

        it do
          expect(distance.to_f).to be_zero
        end
      end
    end

    context 'when passing a scientific number without deviance' do
      context 'when passing a number smaller, but within 1 deviance' do
        let(:other) { DrLight::ScientificNumber.new(111) }

        it do
          expect(distance.to_f).to be_positive
        end

        it 'returns deviance distance' do
          expect(distance.to_f).to eq(0.9)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:other) { DrLight::ScientificNumber.new(139) }

        it do
          expect(distance.to_f).to be_positive
        end

        it 'returns deviance distance' do
          expect(distance.to_f).to eq(1.9)
        end
      end

      context 'when passing a number equal' do
        let(:other) { DrLight::ScientificNumber.new(120) }

        it do
          expect(distance.to_f).to be_zero
        end
      end
    end

    context 'when passing a scientific number and having no deviance' do
      let(:deviance) { 0 }

      context 'when passing a number smaller, but within 1 deviance' do
        let(:other) { DrLight::ScientificNumber.new(111) }

        it do
          expect(distance.to_f).to be_positive
        end

        it do
          expect(distance.to_f).to eq(Float::INFINITY)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:other) { DrLight::ScientificNumber.new(139) }

        it do
          expect(distance.to_f).to be_positive
        end

        it do
          expect(distance.to_f).to eq(Float::INFINITY)
        end
      end

      context 'when passing a number equal' do
        let(:other) { DrLight::ScientificNumber.new(120) }

        it do
          expect(distance.to_f).to be_zero
        end
      end
    end

    context 'when passing a scientific number with deviance' do
      let(:deviance) { 40 }

      context 'when passing a number smaller, but within 1 deviance' do
        let(:other) { DrLight::ScientificNumber.new(80, 30) }

        it do
          expect(distance.to_f).to be_positive
        end

        it 'returns deviance distance with combined deviance' do
          expect(distance.to_f).to eq(0.8)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:other) { DrLight::ScientificNumber.new(30, 30) }

        it do
          expect(distance.to_f).to be_positive
        end

        it 'returns deviance distance with combined deviance' do
          expect(distance.to_f).to eq(1.8)
        end
      end

      context 'when passing a number equal' do
        let(:other) { DrLight::ScientificNumber.new(120, 30) }

        it do
          expect(distance.to_f).to be_zero
        end
      end
    end

    context 'when passing a number with deviance and having no deviance' do
      let(:deviance) { 0 }

      context 'when passing a number smaller, but within 1 deviance' do
        let(:other) { DrLight::ScientificNumber.new(111, 10) }

        it do
          expect(distance.to_f).to be_positive
        end

        it 'returns deviance distance with combined deviance' do
          expect(distance.to_f).to eq(0.9)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:other) { DrLight::ScientificNumber.new(139, 10) }

        it do
          expect(distance.to_f).to be_positive
        end

        it 'returns deviance distance with combined deviance' do
          expect(distance.to_f).to eq(1.9)
        end
      end

      context 'when passing a number equal' do
        let(:other) { DrLight::ScientificNumber.new(120, 10) }

        it do
          expect(distance.to_f).to be_zero
        end
      end
    end
  end
end
