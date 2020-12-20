class CreateEmblemeds < ActiveRecord::Migration[6.1]
  def change
    create_table :emblemeds, if_not_exists: true do |t|
      t.integer :emblem_id
      t.integer :user_id

      t.timestamps
    end
  end
end
