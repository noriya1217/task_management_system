class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :subject, :string, null: false
    change_column :tasks, :content, :string, null: false
  end
end
