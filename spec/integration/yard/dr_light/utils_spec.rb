# frozen_string_literal: true

describe DrLight::Utils do
  describe '.order' do
    describe 'yard' do
      it 'returns order 1 for -100' do
        expect(described_class.order(-100)).to eq(2)
      end

      it 'returns order -2 for 0.01' do
        expect(described_class.order(0.01)).to eq(-2)
      end

      it 'returns order 0 for 0' do
        expect(described_class.order(0)).to eq(0)
      end
    end
  end

  describe '.order_difference' do
    describe 'yard' do
      subject(:difference) do
        described_class.order_difference(-10, 0.1)
      end

      it 'returns order difference between numbers' do
        expect(difference).to eq(2)
      end
    end
  end
end
