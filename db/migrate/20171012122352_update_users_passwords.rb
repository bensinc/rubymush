class UpdateUsersPasswords < ActiveRecord::Migration[5.0]
  def change
    add_column :things, :salt, :string
  end
end
