class MakeGamesUnique < ActiveRecord::Migration
  def change
    add_index :games, [:team1_id, :team2_id, :game_datetime], unique: true
  end
end
