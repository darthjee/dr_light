# frozen_string_literal: true

require 'spec_helper'

shared_examples 'value normalized' do |order:, expctd_order: 1, devnc_fctr: 0|
  let(:multiplier)          { 0.1 * 10**order }
  let(:expected_multiplier) { 10**expctd_order }
  let(:random)              { Random.rand * 0.9 + 0.1 }
  let(:deviance) do
    Random.rand * multiplier * devnc_fctr
  end

  context 'when value is positive' do
    let(:value) { random * multiplier }
    let(:range) do
      [0.1 * expected_multiplier, expected_multiplier]
    end

    it 'returns an order 1 positive number' do
      expect(normalizer.value).to be_between(*range)
    end
  end

  context 'when value is positive' do
    let(:value) { -1 * random * multiplier }
    let(:range) do
      [-expected_multiplier, -0.1 * expected_multiplier]
    end

    it 'returns an order 1 positive number' do
      expect(normalizer.value).to be_between(*range)
    end
  end
end

describe DrLight::ScientificNumber::Normalizer do
  subject(:normalizer) do
    described_class.new(value: value, deviance: deviance)
  end

  describe '#value' do
    context 'when there is no deviance' do
      let(:deviance) { 0 }

      context 'when value has order 2' do
        it_behaves_like 'value normalized', order: 2
      end

      context 'when value has order 3' do
        it_behaves_like 'value normalized', order: 3
      end

      context 'when value has order -2' do
        it_behaves_like 'value normalized', order: -2
      end
    end

    context 'when deviance has the same order as the value' do
      context 'when number has 2 digits' do
        it_behaves_like 'value normalized', order: 2, devnc_fctr: 1
      end

      context 'when number has 3 digits' do
        it_behaves_like 'value normalized', order: 3, devnc_fctr: 1
      end

      context 'when negative number only has 2 digits and order 1' do
        let(:value)    { -1.2 }
        let(:deviance) { 1.3 }

        it 'shows 2 digits' do
          expect(normalizer.value).to eq(-1.2)
        end
      end

      context 'when negative number has 3 digits and order 1' do
        let(:value)    { -1.23 }
        let(:deviance) { 1.34 }

        it 'shows 2 digits' do
          expect(normalizer.value).to eq(-1.23)
        end
      end

      context 'when negative number only has 2 digits and order 10^-1' do
        let(:value)    { -0.12 }
        let(:deviance) { 0.13 }

        it 'shows 2 digits' do
          expect(normalizer.value).to eq(-1.2)
        end
      end

      context 'when negative number has 3 digits and order 10^-1' do
        let(:value)    { -0.123 }
        let(:deviance) { 0.134 }

        it 'shows 2 digits' do
          expect(normalizer.value).to eq(-1.23)
        end
      end

      context 'when positive number only has 2 digits and order 10' do
        let(:value)    { 12 }
        let(:deviance) { 13 }

        it 'shows 2 digits' do
          expect(normalizer.value).to eq(1.2)
        end
      end

      context 'when positive number has 3 digits and order 10^2' do
        let(:value)    { 123 }
        let(:deviance) { 134 }

        it 'shows 2 digits' do
          expect(normalizer.value).to eq(1.23)
        end
      end

      context 'when positive number only has 2 digits and order 1' do
        let(:value)    { 1.2 }
        let(:deviance) { 1.3 }

        it 'shows 2 digits' do
          expect(normalizer.value).to eq(1.2)
        end
      end

      context 'when positive number has 3 digits and order 1' do
        let(:value)    { 1.23 }
        let(:deviance) { 1.34 }

        it 'shows 2 digits' do
          expect(normalizer.value).to eq(1.23)
        end
      end

      context 'when positive number only has 2 digits and order 10^-1' do
        let(:value)    { 0.12 }
        let(:deviance) { 0.13 }

        it 'shows 2 digits' do
          expect(normalizer.value).to eq(1.2)
        end
      end

      context 'when positive number has 3 digits and order 10^-1' do
        let(:value) { 0.123 }
        let(:deviance) { 0.134 }

        it 'shows 2 digits' do
          expect(normalizer.value).to eq(1.23)
        end
      end
    end

    context 'when deviance has smaller order than the value' do
      context 'when negative number only has 2 digits and order 10' do
        let(:value)    { -12 }
        let(:deviance) { 0.13 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-1.200)
        end
      end

      context 'when negative number has 3 digits and order 10^2' do
        let(:value)    { -123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-1.230)
        end
      end

      context 'when negative number only has 2 digits and order 1' do
        let(:value)    { -1.2 }
        let(:deviance) { 0.013 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-1.200)
        end
      end

      context 'when negative number has 3 digits and order 1' do
        let(:value)    { -1.23 }
        let(:deviance) { 0.0134 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-1.230)
        end
      end

      context 'when negative number only has 2 digits and order 10^-1' do
        let(:value)    { -0.12 }
        let(:deviance) { 0.0013 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-1.200)
        end
      end

      context 'when negative number has 3 digits and order 10^-1' do
        let(:value)    { -0.123 }
        let(:deviance) { 0.00134 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-1.230)
        end
      end

      context 'when positive number only has 2 digits and order 10' do
        let(:value)    { 12 }
        let(:deviance) { 0.13 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(1.200)
        end
      end

      context 'when positive number has 3 digits and order 10^2' do
        let(:value)    { 123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(1.230)
        end
      end

      context 'when positive number only has 2 digits and order 1' do
        let(:value)    { 1.2 }
        let(:deviance) { 0.013 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(1.200)
        end
      end

      context 'when positive number has 3 digits and order 1' do
        let(:value)    { 1.23 }
        let(:deviance) { 0.0134 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(1.230)
        end
      end

      context 'when positive number only has 2 digits and order 10^-1' do
        let(:value)    { 0.12 }
        let(:deviance) { 0.0013 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(1.200)
        end
      end

      context 'when positive number has 3 digits and order 10^-1' do
        let(:value)    { 0.123 }
        let(:deviance) { 0.00134 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(1.230)
        end
      end
    end

    context 'when deviance has bigger order than the value' do
      context 'when negative number only has 2 digits and order 10' do
        let(:value)    { -12 }
        let(:deviance) { 130 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-0.12)
        end
      end

      context 'when negative number has 3 digits and order 10^2' do
        let(:value)    { -123 }
        let(:deviance) { 1340 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-0.123)
        end
      end

      context 'when negative number only has 2 digits and order 1' do
        let(:value)    { -1.2 }
        let(:deviance) { 13 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-0.12)
        end
      end

      context 'when negative number has 3 digits and order 1' do
        let(:value)    { -1.23 }
        let(:deviance) { 13.4 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-0.123)
        end
      end

      context 'when negative number only has 2 digits and order 10^-1' do
        let(:value)    { -0.12 }
        let(:deviance) { 1.3 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-0.12)
        end
      end

      context 'when negative number has 3 digits and order 10^-1' do
        let(:value)    { -0.123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(-0.123)
        end
      end

      context 'when positive number only has 2 digits and order 10' do
        let(:value)    { 12 }
        let(:deviance) { 0.13 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(1.200)
        end
      end

      context 'when positive number has 3 digits and order 10^2' do
        let(:value)    { 123 }
        let(:deviance) { 1340 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(0.123)
        end
      end

      context 'when positive number only has 2 digits and order 1' do
        let(:value)    { 1.2 }
        let(:deviance) { 13 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(0.12)
        end
      end

      context 'when positive number has 3 digits and order 1' do
        let(:value)    { 1.23 }
        let(:deviance) { 13.4 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(0.123)
        end
      end

      context 'when positive number only has 2 digits and order 10^-1' do
        let(:value)    { 0.12 }
        let(:deviance) { 1.3 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(0.12)
        end
      end

      context 'when positive number has 3 digits and order 10^-1' do
        let(:value)    { 0.123 }
        let(:deviance) { 1.34 }

        it 'shows 2 deviance digits' do
          expect(normalizer.value).to eq(0.123)
        end
      end
    end
  end
end
