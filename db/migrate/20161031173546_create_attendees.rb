class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :user_id, foreign_key: true
      t.integer :event_id, foreign_key: true

      t.timestamps null: false
    end
  end
end
