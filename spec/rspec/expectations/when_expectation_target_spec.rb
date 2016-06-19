require 'spec_helper'

module RSpec
  module Expectations
    describe WhenExpectationTarget do
      subject { WhenExpectationTarget.new(7, when_expected) }
      let(:when_expected) { true }

      it 'constructs a new instance with access to the given arguments' do
        expect(subject.target).to eq 7
        expect(subject.when_expected).to be_truthy
      end

      context 'success' do
        it 'calls to matcher' do
          expect {
            subject.to eq 7
          }.not_to raise_error
        end

        it 'calls not_to/to_not matcher' do
          expect {
            subject.not_to eq 6
          }.not_to raise_error

          expect {
            subject.to_not eq 6
          }.not_to raise_error
        end

        it 'calls to matcher (not inverted)' do
          expect {
            subject.with_inverse.to eq 7
          }.not_to raise_error
        end

        it 'calls not_to/to_not matcher (not inverted)' do
          expect {
            subject.with_inverse.not_to eq 6
          }.not_to raise_error

          expect {
            subject.with_inverse.to_not eq 6
          }.not_to raise_error
        end
      end

      context 'failure' do
        it 'calls to matcher' do
          expect {
            subject.to eq 6
          }.to fail_including 'expected: 6', 'got: 7'
        end

        it 'calls not_to/to_not matcher' do
          expect {
            subject.not_to eq 7
          }.to fail_including 'expected: value != 7', 'got: 7'

          expect {
            subject.to_not eq 7
          }.to fail_including 'expected: value != 7', 'got: 7'
        end

        it 'calls to matcher (not inverted)' do
          expect {
            subject.with_inverse.to eq 6
          }.to fail_including 'expected: 6', 'got: 7'
        end

        it 'calls not_to/to_not matcher (not inverted)' do
          expect {
            subject.with_inverse.not_to eq 7
          }.to fail_including 'expected: value != 7', 'got: 7'

          expect {
            subject.with_inverse.to_not eq 7
          }.to fail_including 'expected: value != 7', 'got: 7'
        end
      end

      context 'when not expected' do
        let(:when_expected) { false }

        it 'constructs a new instance with access to the given arguments' do
          expect(subject.target).to eq 7
          expect(subject.when_expected).to be_falsey
        end

        context 'success' do
          it 'does not call to matcher' do
            expect {
              subject.to eq 6
            }.not_to raise_error
          end

          it 'does not call not_to/to_not matcher' do
            expect {
              subject.not_to eq 7
            }.not_to raise_error

            expect {
              subject.to_not eq 7
            }.not_to raise_error
          end

          it 'calls to matcher (inverted)' do
            expect {
              subject.with_inverse.to eq 6
            }.not_to raise_error
          end

          it 'calls not_to/to_not matcher (inverted)' do
            expect {
              subject.with_inverse.not_to eq 7
            }.not_to raise_error

            expect {
              subject.with_inverse.to_not eq 7
            }.not_to raise_error
          end
        end

        context 'failure' do
          it 'does not call to matcher' do
            expect {
              subject.to eq 7
            }.not_to raise_error
          end

          it 'does not call not_to/to_not matcher' do
            expect {
              subject.not_to eq 6
            }.not_to raise_error

            expect {
              subject.to_not eq 6
            }.not_to raise_error
          end

          it 'calls to matcher (inverted)' do
            expect {
              subject.with_inverse.to eq 7
            }.to fail_including 'expected: value != 7', 'got: 7'
          end

          it 'calls not_to/to_not matcher (inverted)' do
            expect {
              subject.with_inverse.not_to eq 6
            }.to fail_including 'expected: 6', 'got: 7'

            expect {
              subject.with_inverse.to_not eq 6
            }.to fail_including 'expected: 6', 'got: 7'
          end
        end
      end
    end
  end
end
