class UpdateCodes < ActiveRecord::Migration
  def change
    add_column :codes, :thing_id, :integer
    add_column :codes, :url, :string
  end
end
