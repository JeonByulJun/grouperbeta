class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :teamname
      t.string :belong
      t.string :location
      t.timestamps null: false
    end
  end
end
