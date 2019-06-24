100.times do |n|
  subject = Faker::Beer.brand
  content = Faker::Beer.name
  expired_at = Faker::Time.between(DateTime.now , DateTime.now + 2)
  state = ['未着手','着手中','完了'].sample
  priority = [0, 1, 2].sample
  Task.create!(
              subject: subject,
              content: content,
              expired_at: expired_at,
              state: state,
              priority: priority,
              )
end


# 7000.times do |n|
#   subject = Faker::Beer.brand
#   content = Faker::Beer.name
#   expired_at = Faker::Time.between(DateTime.now , DateTime.now + 2)
#   # state = ['未着手','着手中','完了'].sample
#   state = '未着手'
#   Task.create!(
#               subject: subject,
#               content: content,
#               expired_at: expired_at,
#               state: state,
#               )
# end

# 2000.times do |n|
#   subject = Faker::Beer.brand
#   content = Faker::Beer.name
#   expired_at = Faker::Time.between(DateTime.now , DateTime.now + 2)
#   # state = ['未着手','着手中','完了'].sample
#   state = '着手中'
#   Task.create!(
#               subject: subject,
#               content: content,
#               expired_at: expired_at,
#               state: state,
#               )
# end

# 1000.times do |n|
#   subject = Faker::Beer.brand
#   content = Faker::Beer.name
#   expired_at = Faker::Time.between(DateTime.now , DateTime.now + 2)
#   # state = ['未着手','着手中','完了'].sample
#   state = '完了'
#   Task.create!(
#               subject: subject,
#               content: content,
#               expired_at: expired_at,
#               state: state,
#               )
# end