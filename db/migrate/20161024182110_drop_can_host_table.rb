class DropCanHostTable < ActiveRecord::Migration
  def change
    drop_table :can_hosts
  end
end
