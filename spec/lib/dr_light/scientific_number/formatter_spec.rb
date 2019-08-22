# frozen_string_literal: true

require 'spec_helper'

describe DrLight::ScientificNumber::Formatter do
  subject(:formatter) { described_class.new(normalizer) }

  let(:normalizer) do
    DrLight::ScientificNumber::Normalizer.new(value: value, deviance: deviance)
  end

  describe '#format_string' do
    context 'when there is no deviance' do
      let(:deviance) { 0 }

      context 'when negative number only has 2 digits and order 10' do
        let(:value) { -12 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1fe%<exponential>d')
        end
      end

      context 'when negative number has 3 digits and order 10^2' do
        let(:value) { -123 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1fe%<exponential>d')
        end
      end

      context 'when negative number only has 2 digits and order 1' do
        let(:value) { -1.2 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1f')
        end
      end

      context 'when negative number has 3 digits and order 1' do
        let(:value) { -1.23 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1f')
        end
      end

      context 'when negative number only has 2 digits and order 10^-1' do
        let(:value) { -0.12 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1fe%<exponential>d')
        end
      end

      context 'when negative number has 3 digits and order 10^-1' do
        let(:value) { -0.123 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1fe%<exponential>d')
        end
      end

      context 'when positive number only has 2 digits and order 10' do
        let(:value) { 12 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1fe%<exponential>d')
        end
      end

      context 'when positive number has 3 digits and order 10^2' do
        let(:value) { 123 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1fe%<exponential>d')
        end
      end

      context 'when positive number only has 2 digits and order 1' do
        let(:value) { 1.2 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1f')
        end
      end

      context 'when positive number has 3 digits and order 1' do
        let(:value) { 1.23 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1f')
        end
      end

      context 'when positive number only has 2 digits and order 10^-1' do
        let(:value) { 0.12 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1fe%<exponential>d')
        end
      end

      context 'when positive number has 3 digits and order 10^-1' do
        let(:value) { 0.123 }

        it 'shows 2 digits' do
          expect(formatter.format_string).to eq('%<value>.1fe%<exponential>d')
        end
      end
    end

    context 'when deviance has the same order as the value' do
      context 'when negative number only has 2 digits and order 10' do
        let(:value)    { -12 }
        let(:deviance) { 13 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when negative number has 3 digits and order 10^2' do
        let(:value)    { -123 }
        let(:deviance) { 134 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when negative number only has 2 digits and order 1' do
        let(:value)    { -1.2 }
        let(:deviance) { 1.3 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)')
        end
      end

      context 'when negative number has 3 digits and order 1' do
        let(:value)    { -1.23 }
        let(:deviance) { 1.34 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)')
        end
      end

      context 'when negative number only has 2 digits and order 10^-1' do
        let(:value)    { -0.12 }
        let(:deviance) { 0.13 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when negative number has 3 digits and order 10^-1' do
        let(:value)    { -0.123 }
        let(:deviance) { 0.134 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number only has 2 digits and order 10' do
        let(:value)    { 12 }
        let(:deviance) { 13 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number has 3 digits and order 10^2' do
        let(:value)    { 123 }
        let(:deviance) { 134 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number only has 2 digits and order 1' do
        let(:value)    { 1.2 }
        let(:deviance) { 1.3 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)')
        end
      end

      context 'when positive number has 3 digits and order 1' do
        let(:value)    { 1.23 }
        let(:deviance) { 1.34 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)')
        end
      end

      context 'when positive number only has 2 digits and order 10^-1' do
        let(:value)    { 0.12 }
        let(:deviance) { 0.13 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number has 3 digits and order 10^-1' do
        let(:value) { 0.123 }
        let(:deviance) { 0.134 }

        it 'shows 2 digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end
    end

    context 'when deviance has smaller order than the value' do
      context 'when negative number only has 2 digits and order 10' do
        let(:value)    { -12 }
        let(:deviance) { 0.13 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when negative number has 3 digits and order 10^2' do
        let(:value)    { -123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when negative number only has 2 digits and order 1' do
        let(:value)    { -1.2 }
        let(:deviance) { 0.013 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)')
        end
      end

      context 'when negative number has 3 digits and order 1' do
        let(:value)    { -1.23 }
        let(:deviance) { 0.0134 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)')
        end
      end

      context 'when negative number only has 2 digits and order 10^-1' do
        let(:value)    { -0.12 }
        let(:deviance) { 0.0013 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when negative number has 3 digits and order 10^-1' do
        let(:value)    { -0.123 }
        let(:deviance) { 0.00134 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number only has 2 digits and order 10' do
        let(:value)    { 12 }
        let(:deviance) { 0.13 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number has 3 digits and order 10^2' do
        let(:value)    { 123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number only has 2 digits and order 1' do
        let(:value)    { 1.2 }
        let(:deviance) { 0.013 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)')
        end
      end

      context 'when positive number has 3 digits and order 1' do
        let(:value)    { 1.23 }
        let(:deviance) { 0.0134 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)')
        end
      end

      context 'when positive number only has 2 digits and order 10^-1' do
        let(:value)    { 0.12 }
        let(:deviance) { 0.0013 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number has 3 digits and order 10^-1' do
        let(:value)    { 0.123 }
        let(:deviance) { 0.00134 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)e%<exponential>d')
        end
      end
    end

    context 'when deviance has bigger order than the value' do
      context 'when negative number only has 2 digits and order 10' do
        let(:value)    { -12 }
        let(:deviance) { 130 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when negative number has 3 digits and order 10^2' do
        let(:value)    { -123 }
        let(:deviance) { 1340 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when negative number only has 2 digits and order 1' do
        let(:value)    { -1.2 }
        let(:deviance) { 13 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when negative number has 3 digits and order 1' do
        let(:value)    { -1.23 }
        let(:deviance) { 13.4 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when negative number only has 2 digits and order 10^-1' do
        let(:value)    { -0.12 }
        let(:deviance) { 1.3 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)')
        end
      end

      context 'when negative number has 3 digits and order 10^-1' do
        let(:value)    { -0.123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)')
        end
      end

      context 'when positive number only has 2 digits and order 10' do
        let(:value)    { 12 }
        let(:deviance) { 0.13 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.3f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number has 3 digits and order 10^2' do
        let(:value)    { 123 }
        let(:deviance) { 1340 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number only has 2 digits and order 1' do
        let(:value)    { 1.2 }
        let(:deviance) { 13 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number has 3 digits and order 1' do
        let(:value)    { 1.23 }
        let(:deviance) { 13.4 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)e%<exponential>d')
        end
      end

      context 'when positive number only has 2 digits and order 10^-1' do
        let(:value)    { 0.12 }
        let(:deviance) { 1.3 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)')
        end
      end

      context 'when positive number has 3 digits and order 10^-1' do
        let(:value)    { 0.123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(formatter.format_string)
            .to eq('%<value>.1f(%<deviance>d)')
        end
      end
    end
  end
end
