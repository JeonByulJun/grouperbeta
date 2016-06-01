class CreateFilemessages < ActiveRecord::Migration
  def change
    create_table :filemessages do |t|
      t.integer :message_id
      t.integer :chat_id
      t.timestamps null: false
    end
  end
end
