class CreateForums < ActiveRecord::Migration[6.1]
  def change
    # this just copies the exact format the starmen.net forums use now as it exists right now
    # the if not exists is for production usage
    create_table :forums, if_not_exists: true do |t|
      t.string :name
      t.text :tagline
      t.boolean :read_by_column
      t.boolean :read_require_login
      t.boolean :post_reply
      t.string :require_acl
      t.boolean :require_first_key
      t.integer :category_id
      t.boolean :post_new_topic
      t.integer :post_count
      t.datetime :last_message
      t.boolean :mod_forum, :default => false
      t.integer :sprite_id
      t.string :nickname
      t.boolean :allow_images, :default => false
      t.boolean :hidden, :default => false
      t.integer :order
      t.boolean :disable_listing_on_forumspy
      t.boolean :disable_polls, :default => false
      t.boolean :serious_business
      t.boolean :allow_attachments, :default => true, :null => false
      t.boolean :disable_swear_filter, :default => false

      t.timestamps
    end
  end
end
