class ArticleWithOpposite < ActiveRecord::Base
  include ActAsTimeAsBoolean

  time_as_boolean :active, opposite: :inactive
end
