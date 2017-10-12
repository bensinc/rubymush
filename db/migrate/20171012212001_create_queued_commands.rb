class CreateQueuedCommands < ActiveRecord::Migration
  def change
    create_table :queued_commands do |t|
      t.column :thing_id, :integer
      t.column :name, :string
      t.column :parameters, :string
      t.timestamps null: false
    end
  end
end
