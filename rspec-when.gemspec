Gem::Specification.new do |s|
  s.name              = 'rspec-when'
  s.version           = '0.0.2'
  s.summary           = 'RSpec extension for when syntax'
  s.author            = 'Andrew Bromwich'
  s.email             = 'a.bromwich@gmail.com'
  s.homepage          = 'http://github.com/abrom/rspec-when'
  s.license           = 'MIT'

  s.extra_rdoc_files  = %w[README.md]
  s.rdoc_options      = %w[--main README.md --markup markdown]
  s.require_paths     = %w[lib]

  s.files = %w[README.md] + Dir.glob('lib/**/*.rb')

  s.add_dependency 'rspec-expectations', '>= 2.0', '< 5.0'
end
