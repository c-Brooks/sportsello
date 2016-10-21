class CreateCanHosts < ActiveRecord::Migration
  def change
    create_table :can_hosts do |t|
      t.references :venue, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
