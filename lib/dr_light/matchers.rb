# frozen_string_literal: true

module DrLight
  module Matchers
    autoload :CloseTo, 'dr_light/matchers/close_to'

    def be_close_to(expected, deviance: nil)
      CloseTo.new(expected, deviance)
    end
  end
end
