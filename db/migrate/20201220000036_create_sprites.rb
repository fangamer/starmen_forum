class CreateSprites < ActiveRecord::Migration[6.1]
  def change
    create_table :sprites, if_not_exists: true do |t|
      t.integer :size
      t.string :content_type
      t.string :filename
      t.integer :height
      t.integer :width
      t.string :title
      t.boolean :visibility
      t.integer :requires_group_id

      t.timestamps
    end
  end
end
