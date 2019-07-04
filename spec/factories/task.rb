FactoryBot.define do
  factory :task do
    subject { 'test_task_01' }
    content { 'testtesttest' }
    expired_at { Time.current }
    user_id { User.first.id }
  end

  factory :second_task, class: Task do
    subject { 'test_task_02' }
    content { 'samplesample' }
    expired_at { Time.current }
    user_id { User.first.id }
  end

  factory :third_task, class: Task do
    subject { 'test_task_03' }
    content { 'hogehogehoge' }
    expired_at { Time.current }
    user_id { User.first.id }
  end

  factory :fourth_task, class: Task do
    subject { 'test_task_04' }
    content { 'piyopiyopiyo' }
    expired_at { Time.current }
    user_id { User.last.id }
  end
end