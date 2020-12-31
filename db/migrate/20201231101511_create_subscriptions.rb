class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions, if_not_exists: true do |t|
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end

    add_index :subscriptions, [:user_id,:topic_id], if_not_exists: true
  end
end
