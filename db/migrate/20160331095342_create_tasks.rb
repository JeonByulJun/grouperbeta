class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :taskname
      t.date :duedate
      t.integer :sender
      t.integer :wansungdo
      t.integer :team_id
      t.timestamps null: false
    end
  end
end
