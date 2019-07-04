FactoryBot.define do
  factory :admin do
    user_id { User.first.id }
  end

  factory :second_admin, class: Admin do
    user_id { User.last.id }
  end
end
