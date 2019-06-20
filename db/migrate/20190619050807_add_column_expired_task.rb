class AddColumnExpiredTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expired_at, :datetime, default: Time.current, null: false
  end
end
