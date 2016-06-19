module RSpec
  module Expectations
    # Wraps the target of an expectation and allowing of optional expectations
    # as well as testing expectation inverses
    #
    # @example
    #   expect(something).when(flag) # => WhenExpectationTarget testing when `flag`
    #
    #   # `when` used with `to`
    #   expect(actual).when(flag).to eq(3)
    #   # is the equivalent of
    #   if flag
    #     expect(actual).to eq(3)
    #   end
    #
    #   # `when` used with `with_inverse` and `to`
    #   expect(actual).when(flag).with_inverse.to eq(3)
    #   # is the equivalent of
    #   if flag
    #     expect(actual).to eq(3)
    #   else
    #     expect(actual).not_to eq(3)
    #   end
    #
    # @note `WhenExpectationTarget` is not intended to be instantiated
    #   directly. Use `expect(target).when(flag)` instead

    class WhenExpectationTarget < ExpectationTarget
      # @return [Object] the target of the expectation
      attr_reader :target

      # @return [Boolean] is the target expected?
      attr_reader :when_expected

      def initialize(value, when_expected)
        @target = value
        @when_expected = when_expected
        @with_inverse = false
      end

      # Indicates whether the inverse of the expectation should be applied
      # should the `when` flag be false
      def with_inverse
        @with_inverse = true
        self
      end

      alias_method :expect_to, :to
      alias_method :expect_not_to, :not_to

      # When expected, it will run the given expectation, passing if `matcher` returns true.
      # When not expected and we're also testing the inverse, it will run the given expectation,
      # passing if `matcher` returns false.
      # @example
      #   expect(value).when(flag).to eq(5)
      #   expect(value).when(flag).with_inverse.to eq(5)
      #   expect { perform }.when(flag).to raise_error
      # @param [Matcher]
      #   matcher
      # @param [String or Proc] message optional message to display when the expectation fails
      # @return [Boolean] true if the expectation succeeds (else raises)
      # @see RSpec::Matchers
      def to(matcher = nil, message = nil, &block)
        if @when_expected
          super
        elsif @with_inverse
          expect_not_to matcher, message, &block
        end
      end

      # When expected, it will run the given expectation, passing if `matcher` returns false.
      # When not expected and we're also testing the inverse, it will run the given expectation,
      # passing if `matcher` returns true.
      # @example
      #   expect(value).when(flag).not_to eq(5)
      #   expect(value).when(flag).with_inverse.not_to eq(5)
      # @param [Matcher]
      #   matcher
      # @param [String or Proc] message optional message to display when the expectation fails
      # @return [Boolean] false if the negative expectation succeeds (else raises)
      # @see RSpec::Matchers
      def not_to(matcher = nil, message = nil, &block)
        if @when_expected
          super
        elsif @with_inverse
          expect_to matcher, message, &block
        end
      end
      alias to_not not_to
    end
  end
end
