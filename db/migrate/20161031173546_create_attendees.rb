class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|

      t.timestamps null: false
    end
  end
end
