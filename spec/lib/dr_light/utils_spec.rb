# frozen_string_literal: true

describe DrLight::Utils do
  describe '.order' do
    context 'when number is bigger than 1' do
      it 'returns positive order' do
        expect(described_class.order(100)).to eq(2)
      end
    end

    context 'when number is smaller than 1 and positive' do
      it 'returns negative order' do
        expect(described_class.order(0.01)).to eq(-2)
      end
    end

    context 'when number is 0' do
      it do
        expect(described_class.order(0)).to eq(0)
      end
    end

    context 'when number is bigger than -1 and negative' do
      it 'returns negative order' do
        expect(described_class.order(-0.01)).to eq(-2)
      end
    end

    context 'when number is smaller than -1' do
      it 'returns positive order' do
        expect(described_class.order(-100)).to eq(2)
      end
    end
  end
end
