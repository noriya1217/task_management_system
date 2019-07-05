class ChangeColumnExpiredDefaultTask < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :expired_at, :datetime, null: false
  end

  def down
    change_column :tasks, :expired_at, :datetime, default: Time.current, null: false
  end
end
