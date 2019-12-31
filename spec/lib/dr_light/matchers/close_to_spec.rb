# frozen_string_literal: true

require 'spec_helper'

fdescribe DrLight::Matchers::CloseTo do
  subject(:matcher) { described_class.new(expected, deviance) }

  let(:expected) { 120 }
  let(:deviance) { 10 }

  describe 'matches?' do
    context 'when passing a number' do
      context 'when passing a number smaller, but within 1 deviance' do
        let(:number) { 111 }

        it do
          expect(matcher).to be_matches(number)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:number) { 139 }

        it do
          expect(matcher).not_to be_matches(number)
        end
      end

      context 'when passing a number equal' do
        let(:number) { 120 }

        it do
          expect(matcher).to be_matches(number)
        end
      end
    end

    context 'when passing a scientific number without deviance' do
      context 'when passing a number smaller, but within 1 deviance' do
        let(:number) { DrLight::ScientificNumber.new(111) }

        it do
          expect(matcher).to be_matches(number)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:number) { DrLight::ScientificNumber.new(139) }

        it do
          expect(matcher).not_to be_matches(number)
        end
      end

      context 'when passing a number equal' do
        let(:number) { DrLight::ScientificNumber.new(120) }

        it do
          expect(matcher).to be_matches(number)
        end
      end
    end

    context 'when passing a scientific number and having no deviance' do
      let(:deviance) { 0 }

      context 'when passing a number smaller, but within 1 deviance' do
        let(:number) { DrLight::ScientificNumber.new(111) }

        it do
          expect(matcher).not_to be_matches(number)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:number) { DrLight::ScientificNumber.new(139) }

        it do
          expect(matcher).not_to be_matches(number)
        end
      end

      context 'when passing a number equal' do
        let(:number) { DrLight::ScientificNumber.new(120) }

        it do
          expect(matcher).to be_matches(number)
        end
      end
    end

    context 'when passing a scientific number with deviance' do
      let(:deviance) { 40 }

      context 'when passing a number smaller, but within 1 deviance' do
        let(:number) { DrLight::ScientificNumber.new(80, 30) }

        it do
          expect(matcher).to be_matches(number)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:number) { DrLight::ScientificNumber.new(30, 30) }

        it do
          expect(matcher).not_to be_matches(number)
        end
      end

      context 'when passing a number equal' do
        let(:number) { DrLight::ScientificNumber.new(120, 30) }

        it do
          expect(matcher).to be_matches(number)
        end
      end
    end

    context 'when passing a number with deviance and having no deviance' do
      let(:deviance) { 0 }

      context 'when passing a number smaller, but within 1 deviance' do
        let(:number) { DrLight::ScientificNumber.new(111, 10) }

        it do
          expect(matcher).to be_matches(number)
        end
      end

      context 'when passing a number bigger, but within 2 deviance' do
        let(:number) { DrLight::ScientificNumber.new(139, 10) }

        it do
          expect(matcher).not_to be_matches(number)
        end
      end

      context 'when passing a number equal' do
        let(:number) { DrLight::ScientificNumber.new(120, 10) }

        it do
          expect(matcher).to be_matches(number)
        end
      end
    end
  end
end
