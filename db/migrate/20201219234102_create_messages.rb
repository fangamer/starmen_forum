class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages, if_not_exists: true do |t|
      t.integer :topic_id
      t.text :body
      t.text :body_original
      t.integer :user_id
      t.string :ip_address
      t.string :hostname
      t.integer :edited_by
      t.boolean :deleted, default: false, null:false
      t.boolean :show_sig
      t.boolean :locked
      t.string :thumbnail
      t.string :thumbnail_ids
      t.integer :poll_id
      t.integer :score
      t.boolean :disable_smilies, default: false
      t.boolean :disable_textile
      t.integer :emblem_id
      t.integer :deleted_by

      t.timestamps
    end
  end
end
