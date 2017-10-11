class UserUpdates < ActiveRecord::Migration
  def change
    add_column :things, :credits, :integer, default: 100
    add_column :things, :last_interaction_at, :datetime
  end
end
