class ChangeColumnExpiredDefaultNilTask < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :expired_at, :datetime, default: nil, null: false
  end

  def down
    change_column :tasks, :expired_at, :datetime, default: Time.current, null: false
  end
end
