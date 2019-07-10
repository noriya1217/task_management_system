require 'rails_helper'

RSpec.describe UserLabel, type: :model do
  before do
    User.create!(name: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password')
  end

  it 'nameの値がnilの状態で保存するとNotNull例外評価になる' do
    user_label = UserLabel.new(name: nil, user_id: User.first.id)
    # expect { user_label.save }.to raise_error(ActiveRecord::NotNullViolation)
    expect(user_label.save).to be_falsey
  end

  it 'user_idの値がnilの状態で保存するとNotNull例外評価になる' do
    user_label = UserLabel.new(name: '失敗テスト', user_id: nil)
    expect(user_label.save).to be_falsey
  end

  it 'UserLabelテーブルに正しく保存される' do
    user_label = UserLabel.new(name: '成功テスト', user_id: User.first.id)
    expect(user_label.save).to be_truthy
  end
end
