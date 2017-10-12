class CreateObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :things do |t|
      t.column :owner_id, :integer
      t.column :name, :string
      t.column :description, :text
      t.column :location_id, :integer
      t.column :password, :string
      t.column :created_at, :datetime
      t.column :last_login_at, :datetime
      t.column :wizard, :boolean, default: false
      t.column :connected, :boolean, default: false
      t.column :kind, :string, default: 'object'
    end

    add_index(:things, :owner_id)
    add_index(:things, :location_id)
    add_index(:things, :kind)
  end
end
