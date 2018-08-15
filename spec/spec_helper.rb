require 'bundler'

Bundler.require :default, :development

require 'coveralls'
Coveralls.wear!

require 'act_as_time_as_boolean'
require 'combustion'

Combustion.initialize! :active_record

require 'rspec/rails'
