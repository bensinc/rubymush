class UserUpdates2 < ActiveRecord::Migration[5.0]
  def change
    add_column :things, :doing, :string
  end
end
