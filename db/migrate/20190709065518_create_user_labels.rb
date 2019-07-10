class CreateUserLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :user_labels do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
