FactoryBot.define do
  factory :user_labeling do
    task_id { Task.first.id }
    user_label_id { UserLabel.first.id }
  end

  factory :second_user_labeling, class: UserLabeling do
    task_id { Task.first.id }
    user_label_id { UserLabel.last.id }
  end
end
