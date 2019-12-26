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

  describe '.order_difference' do
    subject(:difference) do
      described_class.order_difference(first, second)
    end

    context 'when first is bigger and has greater order' do
      let(:first)  { 1000 }
      let(:second) { 0.01 }

      it 'returns positive' do
        expect(difference).to be_positive
      end
    end

    context 'when first is bigger but has lesser order' do
      let(:first)  { 100 }
      let(:second) { -1000 }

      it 'returns positive' do
        expect(difference).to be_negative
      end
    end

    context 'when first is bigger but has same order' do
      let(:first)  { 100 }
      let(:second) { -100 }

      it 'returns positive' do
        expect(difference).to be_zero
      end
    end

    context 'when first is smaller but has bigger order' do
      let(:first)  { -100 }
      let(:second) { 10 }

      it 'returns positive' do
        expect(difference).to be_positive
      end
    end

    context 'when first is smaller and has smaller order' do
      let(:first)  { -0.1 }
      let(:second) { 10 }

      it 'returns positive' do
        expect(difference).to be_negative
      end
    end

    context 'when first is smaller and has same order' do
      let(:first)  { -0.1 }
      let(:second) { 0.1 }

      it 'returns positive' do
        expect(difference).to be_zero
      end
    end
  end
end
