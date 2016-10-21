class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :venue_id
      t.integer :user_id
      t.integer :rating
      t.text :description
      t.datetime :create_datetime

      t.timestamps null: false
    end
  end
end
