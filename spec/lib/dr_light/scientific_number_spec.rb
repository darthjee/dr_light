# frozen_string_literal: true

require 'spec_helper'

fdescribe DrLight::ScientificNumber do
  subject(:number) { described_class.new(value, deviance) }

  let(:value)    { 120 }
  let(:deviance) { 10 }

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
        let(:value)    { 0.123 }
        let(:deviance) { 0.00134 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('1.230(13)e-1')
        end
      end
    end

    context 'when deviance has bigger order than the value' do
      context 'when negative number only has 2 digits and order 10' do
        let(:value)    { -12 }
        let(:deviance) { 130 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-0.1(13)e2')
        end
      end

      context 'when negative number has 3 digits and order 10^2' do
        let(:value)    { -123 }
        let(:deviance) { 1340 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-0.1(13)e3')
        end
      end

      context 'when negative number only has 2 digits and order 1' do
        let(:value)    { -1.2 }
        let(:deviance) { 13 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-0.1(13)e1')
        end
      end

      context 'when negative number has 3 digits and order 1' do
        let(:value)    { -1.23 }
        let(:deviance) { 13.4 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-0.1(13)e1')
        end
      end

      context 'when negative number only has 2 digits and order 10^-1' do
        let(:value)    { -0.12 }
        let(:deviance) { 1.3 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-0.1(13)')
        end
      end

      context 'when negative number has 3 digits and order 10^-1' do
        let(:value)    { -0.123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('-0.1(13)')
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
        let(:deviance) { 1340 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('0.1(13)e3')
        end
      end

      context 'when positive number only has 2 digits and order 1' do
        let(:value)    { 1.2 }
        let(:deviance) { 13 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('0.1(13)e1')
        end
      end

      context 'when positive number has 3 digits and order 1' do
        let(:value)    { 1.23 }
        let(:deviance) { 13.4 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('0.1(13)e1')
        end
      end

      context 'when positive number only has 2 digits and order 10^-1' do
        let(:value)    { 0.12 }
        let(:deviance) { 1.3 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('0.1(13)')
        end
      end

      context 'when positive number has 3 digits and order 10^-1' do
        let(:value)    { 0.123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(number.to_s).to eq('0.1(13)')
        end
      end
    end
  end

  describe 'deviance_distance?' do
    context 'when passing a scientific number without deviance' do
      context 'when passing a number smaller, but within 1 deviance' do
        let(:other) { described_class.new(111) }

        it do
          expect(number.deviance_distance(other)).to be_positive
        end

        it 'returns deviance distance' do
          expect(number.deviance_distance(other)).to eq(0.9)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:other) { described_class.new(139) }

        it do
          expect(number.deviance_distance(other)).to be_positive
        end

        it 'returns deviance distance' do
          expect(number.deviance_distance(other)).to eq(1.9)
        end
      end

      context 'when passing a number equal' do
        let(:other) { described_class.new(120) }

        it do
          expect(number.deviance_distance(other)).to be_zero
        end
      end
    end

    context 'when passing a scientific number and having no deviance' do
      let(:deviance) { 0 }

      context 'when passing a number smaller, but within 1 deviance' do
        let(:other) { described_class.new(111) }

        it do
          expect(number.deviance_distance(other)).to be_positive
        end

        it do
          expect(number.deviance_distance(other)).to eq(Float::INFINITY)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:other) { described_class.new(139) }

        it do
          expect(number.deviance_distance(other)).to be_positive
        end

        it do
          expect(number.deviance_distance(other)).to eq(Float::INFINITY)
        end
      end

      context 'when passing a number equal' do
        let(:other) { described_class.new(120) }

        it do
          expect(number.deviance_distance(other)).to be_zero
        end
      end
    end

    context 'when passing a scientific number with deviance' do
      let(:deviance) { 40 }

      context 'when passing a number smaller, but within 1 deviance' do
        let(:other) { described_class.new(80, 30) }

        it do
          expect(number.deviance_distance(other)).to be_positive
        end

        it 'returns deviance distance with combined deviance' do
          expect(number.deviance_distance(other)).to eq(0.8)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:other) { described_class.new(30, 30) }

        it do
          expect(number.deviance_distance(other)).to be_positive
        end

        it 'returns deviance distance' do
          expect(number.deviance_distance(other)).to eq(1.8)
        end
      end

      context 'when passing a number equal' do
        let(:other) { described_class.new(120, 30) }

        it do
          expect(number.deviance_distance(other)).to be_zero
        end
      end
    end
  end
end
