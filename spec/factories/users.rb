FactoryBot.define do
  factory :user do
    name { 'hoge' }
    email { 'hoge@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
