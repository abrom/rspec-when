require 'spec_helper'

module RSpec
  module Expectations
    describe ExpectationTarget do
      describe '.when' do
        subject { expect(7).when(true) }
        it { is_expected.to be_a WhenExpectationTarget }

        it 'constructs a new instance with access to the given arguments' do
          expect(subject.target).to eq 7
          expect(subject.when_expected).to be_truthy
        end

        context 'block expectation target' do
          subject do
            expect(target).when(true)
          end
          let(:target) { lambda { } }

          it { is_expected.to be_a WhenExpectationTarget }

          it 'constructs a new instance with access to the given arguments' do
            expect(subject.target).to eq target
            expect(subject.when_expected).to be_truthy
          end
        end
      end
    end
  end
end
