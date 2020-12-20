class CreateSystemPreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :system_preferences, if_not_exists: true do |t|
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
