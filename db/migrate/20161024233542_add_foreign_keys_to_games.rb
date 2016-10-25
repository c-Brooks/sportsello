class AddForeignKeysToGames < ActiveRecord::Migration
  def change
    add_reference :games, :team1_id, references: :teams, index:true
    add_foreign_key :games, :teams, column: :team1_id

    add_reference :games, :team2_id, references: :teams, index:true
    add_foreign_key :games, :teams, column: :team2_id

    add_foreign_key :games, :sports, foreign_key: true
  end
end
