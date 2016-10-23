class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :sport_id
      t.integer :team1_id
      t.integer :team2_id
      t.datetime :game_datetime

      t.timestamps null: false
    end
  end
end
