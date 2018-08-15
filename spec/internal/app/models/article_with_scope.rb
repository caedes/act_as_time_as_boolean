class ArticleWithScope < ActiveRecord::Base
  include ActAsTimeAsBoolean
  self.table_name= 'article'

  time_as_boolean :active, scope: :reactive
end
