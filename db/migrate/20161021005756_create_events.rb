class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :sport_id
      t.integer :team1_id
      t.integer :team2_id
      t.integer :venue_id
      t.datetime :event_datetime

      t.timestamps null: false
    end
  end
end
