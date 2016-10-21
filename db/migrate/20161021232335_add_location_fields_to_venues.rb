class AddLocationFieldsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :longitude, :float
    add_column :venues, :latitiude, :float
    add_column :venues, :address, :text
  end
end
