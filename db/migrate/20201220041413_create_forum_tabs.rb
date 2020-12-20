class CreateForumTabs < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_tabs, if_not_exists: true do |t|
      t.string :name
      t.text :link
      t.integer :forum_id
      t.integer :sprite_id
      t.float :top
      t.float :left

      t.timestamps
    end
  end
end
