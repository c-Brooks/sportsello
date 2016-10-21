class AddSportToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :sport, index: true, foreign_key: true
  end
end
