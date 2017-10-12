class UpdateThingKeys < ActiveRecord::Migration
  def change
    add_column :things, :external_key, :string
  end
end
