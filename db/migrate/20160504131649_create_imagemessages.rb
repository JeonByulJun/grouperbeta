class CreateImagemessages < ActiveRecord::Migration
  def change
    create_table :imagemessages do |t|
      t.integer :message_id
      t.integer :chat_id
      t.timestamps null: false
    end
  end
end
