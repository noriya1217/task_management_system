FactoryBot.define do
  factory :task do
    subject { 'test_task_01' }
    content { 'testtesttest' }
  end

  factory :second_task, class: Task do
    subject { 'test_task_02' }
    content { 'samplesample' }
  end
end