class AddIndexesToThings < ActiveRecord::Migration[6.1]
  def change
    add_index :categories, :nickname

    add_index :forums, :category_id
    add_index :forums, :nickname

    add_index :topics, :forum_id
    add_index :topics, :permalink

    add_index :messages, :topic_id

    add_index :users, :name
  end
end
