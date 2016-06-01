class CreateWhiteboards < ActiveRecord::Migration
  def change
    create_table :whiteboards do |t|
      t.integer :chat_id
      t.text :content
      t.integer :user_id
      t.boolean :edit
      t.timestamps null: false
    end
  end
end
