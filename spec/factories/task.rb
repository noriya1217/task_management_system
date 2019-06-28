FactoryBot.define do
  factory :task do
    subject { 'test_task_01' }
    content { 'testtesttest' }
    user_id { User.first.id }
  end

  factory :second_task, class: Task do
    subject { 'test_task_02' }
    content { 'samplesample' }
    user_id { User.first.id }
  end

  factory :third_task, class: Task do
    subject { 'test_task_03' }
    content { 'hogehogehoge' }
    user_id { User.first.id }
  end
end