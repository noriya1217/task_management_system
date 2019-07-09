FactoryBot.define do
  factory :user_label do
    name { "Vue.js" }
    user_id { User.first.id }
  end

  factory :second_user_label, class: UserLabel do
    name { 'React' }
    user_id { User.first.id }
  end
end
