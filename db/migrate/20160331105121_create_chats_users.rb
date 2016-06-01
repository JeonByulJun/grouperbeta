class CreateChatsUsers < ActiveRecord::Migration
  def change
    create_table :chats_users, :id => false do |t|
      t.integer :chat_id
      t.integer :user_id
    end
    add_index :chats_users, :chat_id
    add_index :chats_users, :user_id

  end
end
