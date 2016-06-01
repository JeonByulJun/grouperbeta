class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.text :title
      t.integer :team_id
      t.timestamps null: false
    end
  end
end
