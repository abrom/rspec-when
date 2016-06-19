module RSpec
  module Expectations
    # DSL extension to expectation target allowing optional expectations
    module WhenExpectationExtensions
      def when(expected)
        WhenExpectationTarget.new @target, expected
      end
    end
    ExpectationTarget.include WhenExpectationExtensions
  end
end
