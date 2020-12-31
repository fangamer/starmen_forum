class AddCreatedAtIndexToMessages < ActiveRecord::Migration[6.1]
  def change
    add_index :messages, :created_at
  end
end
