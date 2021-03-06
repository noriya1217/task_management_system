1.times do |n|
  User.create!(
    name: 'admin',
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    )
  Admin.create!(user_id: User.last.id)
end

10.times do |n|
  name = Faker::Pokemon.name
  email = Faker::Internet.email
  password = 'password'
  User.create!(
              name: name,
              email: email,
              password: password,
              password_confirmation: password,
              )
end

100.times do |n|
  subject = Faker::Beer.brand
  content = Faker::Beer.name
  expired_at = Faker::Time.between(DateTime.now , DateTime.now + 2)
  state = ['未着手','着手中','完了'].sample
  priority = [0, 1, 2].sample
  user_id_array = []
  User.all.each do |user| user_id_array << user.id end
  user_id = user_id_array.sample
  Task.create!(
              subject: subject,
              content: content,
              expired_at: expired_at,
              state: state,
              priority: priority,
              user_id: user_id,
              )
end

10.times do |n|
  name = "test_label_#{n}"
  Label.create!(name: name)
end
