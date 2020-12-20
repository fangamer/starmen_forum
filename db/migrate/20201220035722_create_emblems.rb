class CreateEmblems < ActiveRecord::Migration[6.1]
  def change
    create_table :emblems, if_not_exists: true do |t|
      t.string :name
      t.integer :order
      t.string :permission_name
      t.integer :group_id
      t.string :css

      t.timestamps
    end
  end
end
