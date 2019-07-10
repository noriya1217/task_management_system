require 'rails_helper'

RSpec.describe Label, type: :model do
  it 'nameの値がnilの状態で保存するとNotNull例外評価になる' do
    label = Label.new(name: nil)
    # expect { label.save }.to raise_error(ActiveRecord::NotNullViolation)
    expect(label.save).to be_falsey
  end

  it 'Labelテーブルに正しく保存される' do
    label = Label.new(name: '成功テスト')
    expect(label.save).to be_truthy
  end
end
