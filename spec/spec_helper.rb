require 'rspec/when'
require 'rspec/matchers/fail_matchers'

RSpec.configure { |config| config.include RSpec::Matchers::FailMatchers }
