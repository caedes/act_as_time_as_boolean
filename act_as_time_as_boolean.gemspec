require File.expand_path('../lib/act_as_time_as_boolean/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'act_as_time_as_boolean'
  s.version     = ActAsTimeAsBoolean::VERSION
  s.authors     = ['caedes']
  s.email       = ['laurentromain@gmail.com']
  s.homepage    = 'https://github.com/caedes/act_as_time_as_boolean'
  s.summary     = 'Add time_as_boolean feature to ActiveRecord classes'
  s.description = s.summary

  s.files        = `git ls-files`.split("\n")

  s.require_path = 'lib'

  s.add_dependency 'activesupport', '>= 3.2'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'coveralls', '~> 0.6'
  s.add_development_dependency 'json', '~> 1.7.7'
  s.add_development_dependency 'combustion', '~> 0.5.1'
  s.add_development_dependency 'rspec-rails', '~> 2.14'
  s.add_development_dependency 'sqlite3', '~> 1.3.3'
  s.add_development_dependency 'activerecord', '~> 4.0.4'
end
