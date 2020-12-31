class CreateReads < ActiveRecord::Migration[6.1]
  def change
    create_table :reads, if_not_exists: true do |t|
      t.integer :topic_id
      t.integer :user_id
      t.integer :message_id
      t.datetime :last_view

      t.timestamps
    end

    # fix multiples in the existing database for whatever reason
    # only works if there's two and not three, but there's only doubles in the database right now.
    add_index :reads, [:user_id,:topic_id], if_not_exists: true #create a temp index
    Read.reset_column_information
    multireads = Read.group(:user_id, :topic_id).having("count(*) > 1").count
    multireads.each do |utid,_|
      user_id, topic_id = utid
      oldest_last_view = Read.where(user_id:user_id,topic_id:topic_id).order(last_view: :asc).limit(1).to_a #limit 1, to_a is optimization
      p [user_id,topic_id]
      oldest_last_view.first.destroy
    end

    # remove temp index
    remove_index :reads, [:user_id,:topic_id]
    # add unique index
    add_index :reads, [:user_id,:topic_id], if_not_exists: true, unique: true
  end
end
