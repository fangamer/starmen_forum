class MessageIsDefaultNotDeleted < ActiveRecord::Migration[6.1]
  def change
    change_column_default :messages, :deleted, from: nil, to: false
  end
end
