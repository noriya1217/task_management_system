require 'rails_helper'

RSpec.describe Admin, type: :model do
  it 'user_idの値がnilならNotNull制約違反になる' do
    admin = Admin.new(user_id: nil)
    expect(admin).not_to be_valid
  end

  it 'user_idに入力した値のUserが存在しない場合、登録できないことを確認' do
    admin = Admin.new(user_id: 1)
    expect(admin).not_to be_valid
  end

  it 'user_idに入力した値のUserが存在する場合、登録できることを確認' do
    User.create(
      name: 'tanaka',
      email: 'failure_test@example.com',
      password: 'password',
      password_confirmation: 'password',
      )
    admin = Admin.new(user_id: User.first.id)
    expect(admin).to be_valid
  end
end
