class RemoveUnusefullFieldsFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :venue_id, :integer
    remove_column :events, :sport_id, :integer
  end
end