# frozen_string_literal: true

require 'spec_helper'

xdescribe DrLight::Matchers do
  describe 'be_close_to' do
    context 'when passing numbers' do
      context 'when not giving a range' do
        context 'when they are the same' do
          it do
            expect(10.0).to be_close_to(10)
          end
        end
      end
    end
  end
end
