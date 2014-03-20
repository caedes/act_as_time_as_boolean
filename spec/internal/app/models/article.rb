class Article < ActiveRecord::Base
  include ActAsTimeAsBoolean

  time_as_boolean :active
end
