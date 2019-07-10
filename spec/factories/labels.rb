FactoryBot.define do
  factory :label do
    name { 'Ruby' }
  end

  factory :second_label, class: Label do
    name { 'Python' }
  end
end
