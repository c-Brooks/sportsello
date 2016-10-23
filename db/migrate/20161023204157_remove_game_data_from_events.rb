class RemoveGameDataFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :sport_id
    remove_column :events, :team1_id
    remove_column :events, :team2_id
    remove_column :events, :event_datetime
  end
end
