class CreateThemes < ActiveRecord::Migration[6.1]
  def change
    create_table :themes, if_not_exists: true do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
