class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.column :name, :string
      t.column :password, :string
      t.column :created_at, :datetime
      t.column :last_login_at, :datetime
      t.column :wizard, :boolean, default: false
    end
  end
end
