# frozen_string_literal: true

require 'spec_helper'

describe DrLight::Matchers do
  describe 'be_close_to' do
    subject(:value) { 10.0 }

    context 'when passing numbers without deviance' do
      context 'when they are the same' do
        it do
          expect(value).to be_close_to(10)
        end
      end

      context 'when they are not the same' do
        it do
          expect(value).not_to be_close_to(10.00001)
        end
      end
    end

    context 'when passing numbers with deviance' do
      context 'when they are the same' do
        it do
          expect(value).to be_close_to(10, deviance: 1)
        end
      end

      context 'when they are not the same but close' do
        it do
          expect(value).to be_close_to(11, deviance: 1)
        end
      end

      context 'when they are not the same and not close' do
        it do
          expect(value).not_to be_close_to(11.1, deviance: 1)
        end
      end
    end

    context 'when passing scientific number for expected' do
      context 'when they are the same' do
        let(:expected) { DrLight::ScientificNumber.new(10, 1) }

        it do
          expect(value).to be_close_to(expected)
        end
      end

      context 'when they are not the same but close' do
        let(:expected) { DrLight::ScientificNumber.new(9, 1) }

        it do
          expect(value).to be_close_to(expected)
        end
      end

      context 'when they are not the same and not close' do
        let(:expected) { DrLight::ScientificNumber.new(8.9, 1) }

        it do
          expect(value).not_to be_close_to(expected)
        end
      end
    end

    context 'when scientific number is close to number' do
      let(:value) { DrLight::ScientificNumber.new(10, 1) }

      context 'when they are the same' do
        it do
          expect(value).to be_close_to(10)
        end
      end

      context 'when they are not the same but close' do
        it do
          expect(value).to be_close_to(11)
        end
      end

      context 'when they are not the same but not close' do
        it do
          expect(value).not_to be_close_to(8)
        end
      end
    end

    context 'when both are scientific numbers' do
      let(:value) { DrLight::ScientificNumber.new(10, 3) }

      context 'when they are the same' do
        let(:other) { DrLight::ScientificNumber.new(10, 4) }

        it do
          expect(value).to be_close_to(other)
        end
      end

      context 'when they are not the same but close' do
        let(:other) { DrLight::ScientificNumber.new(5, 4) }

        it do
          expect(value).to be_close_to(other)
        end
      end

      context 'when they are not the same but not close' do
        let(:other) { DrLight::ScientificNumber.new(16, 4) }

        it do
          expect(value).not_to be_close_to(other)
        end
      end
    end
  end
end
