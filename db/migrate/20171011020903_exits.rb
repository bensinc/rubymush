class Exits < ActiveRecord::Migration[5.0]
  def change
    add_column :things, :destination_id, :integer
  end
end
