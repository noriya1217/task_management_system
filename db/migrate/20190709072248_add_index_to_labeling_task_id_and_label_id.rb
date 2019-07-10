class AddIndexToLabelingTaskIdAndLabelId < ActiveRecord::Migration[5.2]
  def change
    add_index :labelings, :task_id
    add_index :labelings, :label_id
  end
end
