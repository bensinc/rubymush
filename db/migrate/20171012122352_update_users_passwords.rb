class UpdateUsersPasswords < ActiveRecord::Migration
  def change
    add_column :things, :salt, :string
  end
end
