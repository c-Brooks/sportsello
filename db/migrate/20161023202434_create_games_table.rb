class CreateGamesTable < ActiveRecord::Migration
  def change
    create_table :games_tables do |t|
      t.integer :sport_id
      t.integer :team1_id
      t.integer :team2_id
      t.datetime :event_datetime

      t.timestamps null: false
    end
  end
end
