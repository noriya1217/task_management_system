require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'subjectの値がnilでNotNull制約違反になる' do
    task = Task.new(subject: nil, content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'contentの値がnilでNotNull制約違反になる' do
    task = Task.new(subject: '失敗テスト', content: nil)
    expect(task).not_to be_valid
  end

  it 'subjectが空ならバリデーションが通らない' do
    task = Task.new(subject:'', content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(subject:'失敗テスト', content: '')
    expect(task).not_to be_valid
  end

  it 'subjectとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(subject: '成功テスト', content: '成功テスト')
    expect(task).to be_valid
  end
end