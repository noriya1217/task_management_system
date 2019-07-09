FactoryBot.define do
  factory :labeling do
    task_id { Task.first.id }
    label_id { Label.last.id }
  end

  factory :second_labeling, class: Labeling do
    task_id { Task.first.id }
    label_id { Label.last.id }
  end
end
