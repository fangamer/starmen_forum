class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics, if_not_exists: true do |t|
      t.integer :forum_id
      t.string :name
      t.integer :user_id
      t.datetime :last_message
      t.integer :latest_message_id
      t.boolean :locked
      t.integer :replies
      t.integer :views
      t.integer :sticky, default: 0
      t.integer :sprite_id
      t.string :byline
      t.string :permalink
      t.string :kind
      t.integer :contest_id
      t.integer :emblem_id
      t.string :original_name
      t.string :original_byline

      t.timestamps
    end
  end
end
