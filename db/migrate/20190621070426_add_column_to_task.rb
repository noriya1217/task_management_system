class AddColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :state, :string, null: false, default: '未着手'
    add_index :tasks, :state
  end
end
