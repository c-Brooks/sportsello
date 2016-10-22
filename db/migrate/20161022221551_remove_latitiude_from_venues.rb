class RemoveLatitiudeFromVenues < ActiveRecord::Migration
  def change
    remove_column :venues, :latitiude, :float
  end
end
