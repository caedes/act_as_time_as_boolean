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
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'combustion'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'activerecord'
end
