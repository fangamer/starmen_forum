class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions, if_not_exists: true do |t|
      t.string :permission
      t.boolean :value
      t.integer :user_id
      t.integer :individual_id

      t.timestamps
    end
  end
end
