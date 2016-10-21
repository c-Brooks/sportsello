class RemoveUnusefullFieldsFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :venue_id, :integer
    remove_column :reviews, :user_id, :integer
    remove_column :reviews, :create_datetime, :datetime
  end
end
