class CreateCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :codes do |t|
      t.column :name, :string
      t.column :code, :text
    end
  end
end
