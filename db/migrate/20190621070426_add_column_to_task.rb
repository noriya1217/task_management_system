class AddColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :state, :integer, null: false, default: 0
    add_index :tasks, :state
  end
end
