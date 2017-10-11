class Exits < ActiveRecord::Migration
  def change
    add_column :things, :destination_id, :integer
  end
end
