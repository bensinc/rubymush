class CreateAttributes < ActiveRecord::Migration[5.0]
  def change
    create_table :atts do |t|
      t.column :thing_id, :integer
      t.column :value, :text
      t.column :name, :string
    end
  end
end
