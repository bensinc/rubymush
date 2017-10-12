class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.column :thing_id, :integer
      t.column :name, :string
      t.column :code, :string
    end
  end
end
