# frozen_string_literal: true

require 'spec_helper'

describe DrLight::ScientificNumber do
  subject(:number) { described_class.new(value, deviance) }

  describe '#to_s' do
    context 'when there is no deviance' do
      subject(:number) { described_class.new(value) }

      context 'when negative number only has 2 digits and order 10' do
        let(:value) { -12 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2e1')
        end
      end

      context 'when negative number has 3 digits and order 10^2' do
        let(:value) { -123 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2e2')
        end
      end

      context 'when negative number only has 2 digits and order 1' do
        let(:value) { -1.2 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2')
        end
      end

      context 'when negative number has 3 digits and order 1' do
        let(:value) { -1.23 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2')
        end
      end

      context 'when negative number only has 2 digits and order 10^-1' do
        let(:value) { -0.12 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2e-1')
        end
      end

      context 'when negative number has 3 digits and order 10^-1' do
        let(:value) { -0.123 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2e-1')
        end
      end

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

    context 'when deviance has the same order as the value' do
      context 'when negative number only has 2 digits and order 10' do
        let(:value)    { -12 }
        let(:deviance) { 13 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2(13)e1')
        end
      end

      context 'when negative number has 3 digits and order 10^2' do
        let(:value)    { -123 }
        let(:deviance) { 134 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2(13)e2')
        end
      end

      context 'when negative number only has 2 digits and order 1' do
        let(:value)    { -1.2 }
        let(:deviance) { 1.3 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2(13)')
        end
      end

      context 'when negative number has 3 digits and order 1' do
        let(:value)    { -1.23 }
        let(:deviance) { 1.34 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2(13)')
        end
      end

      context 'when negative number only has 2 digits and order 10^-1' do
        let(:value)    { -0.12 }
        let(:deviance) { 0.13 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2(13)e-1')
        end
      end

      context 'when negative number has 3 digits and order 10^-1' do
        let(:value)    { -0.123 }
        let(:deviance) { 0.134 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('-1.2(13)e-1')
        end
      end

      context 'when positive number only has 2 digits and order 10' do
        let(:value)    { 12 }
        let(:deviance) { 13 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2(13)e1')
        end
      end

      context 'when positive number has 3 digits and order 10^2' do
        let(:value)    { 123 }
        let(:deviance) { 134 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2(13)e2')
        end
      end

      context 'when positive number only has 2 digits and order 1' do
        let(:value)    { 1.2 }
        let(:deviance) { 1.3 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2(13)')
        end
      end

      context 'when positive number has 3 digits and order 1' do
        let(:value)    { 1.23 }
        let(:deviance) { 1.34 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2(13)')
        end
      end

      context 'when positive number only has 2 digits and order 10^-1' do
        let(:value)    { 0.12 }
        let(:deviance) { 0.13 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2(13)e-1')
        end
      end

      context 'when positive number has 3 digits and order 10^-1' do
        let(:value) { 0.123 }
        let(:deviance) { 0.134 }

        it 'shows 2 digits' do
          expect(number.to_s).to eq('1.2(13)e-1')
        end
      end
    end

    context 'when deviance has smaller order than the value' do
      context 'when negative number only has 2 digits and order 10' do
        let(:value)    { -12 }
        let(:deviance) { 0.13 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-1.200(13)e1')
        end
      end

      context 'when negative number has 3 digits and order 10^2' do
        let(:value)    { -123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-1.230(13)e2')
        end
      end

      context 'when negative number only has 2 digits and order 1' do
        let(:value)    { -1.2 }
        let(:deviance) { 0.013 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-1.200(13)')
        end
      end

      context 'when negative number has 3 digits and order 1' do
        let(:value)    { -1.23 }
        let(:deviance) { 0.0134 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-1.230(13)')
        end
      end

      context 'when negative number only has 2 digits and order 10^-1' do
        let(:value)    { -0.12 }
        let(:deviance) { 0.0013 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-1.200(13)e-1')
        end
      end

      context 'when negative number has 3 digits and order 10^-1' do
        let(:value)    { -0.123 }
        let(:deviance) { 0.00134 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-1.230(13)e-1')
        end
      end

      context 'when positive number only has 2 digits and order 10' do
        let(:value)    { 12 }
        let(:deviance) { 0.13 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('1.200(13)e1')
        end
      end

      context 'when positive number has 3 digits and order 10^2' do
        let(:value)    { 123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('1.230(13)e2')
        end
      end

      context 'when positive number only has 2 digits and order 1' do
        let(:value)    { 1.2 }
        let(:deviance) { 0.013 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('1.200(13)')
        end
      end

      context 'when positive number has 3 digits and order 1' do
        let(:value)    { 1.23 }
        let(:deviance) { 0.0134 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('1.230(13)')
        end
      end

      context 'when positive number only has 2 digits and order 10^-1' do
        let(:value)    { 0.12 }
        let(:deviance) { 0.0013 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('1.200(13)e-1')
        end
      end

      context 'when positive number has 3 digits and order 10^-1' do
        let(:value) { 0.123 }
        let(:deviance) { 0.00134 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('1.230(13)e-1')
        end
      end
    end
  end
end
