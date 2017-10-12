class UpdateThingKeys < ActiveRecord::Migration[5.0]
  def change
    add_column :things, :external_key, :string
  end
end
