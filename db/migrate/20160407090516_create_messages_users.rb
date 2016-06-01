class CreateMessagesUsers < ActiveRecord::Migration
  def change
    create_table :messages_users, :id => false do |t|
      t.integer :message_id
      t.integer :user_id
    end
    add_index :messages_users, :message_id
    add_index :messages_users, :user_id

  end
end
