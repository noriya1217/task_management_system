FactoryBot.define do
  factory :admin do
    user_id { User.first.id }
  end
end
