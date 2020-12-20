class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories, if_not_exists: true do |t|
      t.string :name
      t.string :nickname
      t.integer :order

      t.timestamps
    end
  end
end
