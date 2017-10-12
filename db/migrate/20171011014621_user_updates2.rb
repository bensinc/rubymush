class UserUpdates2 < ActiveRecord::Migration
  def change
    add_column :things, :doing, :string
  end
end
