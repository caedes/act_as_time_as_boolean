ActiveRecord::Schema.define do
  create_table :articles, force: true do |t|
    t.datetime  :active_at
  end

  create_table :article_with_opposites, force: true do |t|
    t.datetime  :active_at
  end
end
