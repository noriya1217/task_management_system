class CreateUserLabelings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_labelings do |t|
      t.references :task, foreign_key: true, null: false
      t.references :user_label, foreign_key: true, null: false

      t.timestamps
    end
  end
end
