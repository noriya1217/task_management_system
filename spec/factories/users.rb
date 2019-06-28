FactoryBot.define do
  factory :user do
    name { 'hoge' }
    email { 'hoge@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :second_user, class: User do
    name { 'piyo' }
    email { 'piyo@example.com' }
    password { 'piyopiyo' }
    password_confirmation { 'piyopiyo' }
  end
end
