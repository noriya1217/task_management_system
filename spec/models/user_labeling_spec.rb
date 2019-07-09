require 'rails_helper'

RSpec.describe UserLabeling, type: :model do
  before do
    User.create!(name: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password')
    Task.create!(subject: 'タスク件名', content: 'テストする', expired_at: Time.current, user_id: User.first.id)
    UserLabel.create!(name: 'testlabel',user_id: User.first.id)
  end

  it 'task_idの値nilの状態で保存するとtaskのバリデーションが通らない' do
    user_labeling = UserLabeling.new(task_id: nil, user_label_id: UserLabel.first.id)
    expect(user_labeling).not_to be_valid
  end

  it 'label_idの値nilの状態で保存するとlabelのバリデーションが通らない' do
    user_labeling = UserLabeling.new(task_id: Task.first.id, user_label_id: nil)
    expect(user_labeling).not_to be_valid
  end

  it 'UserLabelingテーブルに正しく保存される' do
    user_labeling = UserLabeling.new(task_id: Task.first.id, user_label_id: UserLabel.first.id)
    expect(user_labeling).to be_valid
  end

end