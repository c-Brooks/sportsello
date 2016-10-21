class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :website
      t.text :description

      t.timestamps null: false
    end
  end
end
