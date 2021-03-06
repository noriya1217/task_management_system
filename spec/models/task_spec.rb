require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    User.create!(name: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password')
  end

  it 'subjectの値がnilならNotNull制約違反になる' do
    task = Task.new(subject: nil, content: '失敗テスト', expired_at: Time.current, user_id: User.first.id)
    expect(task).not_to be_valid
  end

  it 'contentの値がnilならNotNull制約違反になる' do
    task = Task.new(subject: '失敗テスト', content: nil, expired_at: Time.current, user_id: User.first.id)
    expect(task).not_to be_valid
  end

  it 'subjectが空ならバリデーションが通らない' do
    task = Task.new(subject: '', content: '失敗テスト', expired_at: Time.current, user_id: User.first.id)
    expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(subject:'失敗テスト', content: '', expired_at: Time.current, user_id: User.first.id)
    expect(task).not_to be_valid
  end

  it 'subjectとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(subject: '成功テスト', content: '成功テスト', expired_at: Time.current, user_id: User.first.id)
    expect(task).to be_valid
  end

  it 'State"完了"で検索されない' do
    Task.create(subject: '失敗テスト', content: '失敗テスト', expired_at: Time.current, state: '未着手', user_id: User.first.id)
    task = Task.search_ransack("subject_cont"=>"", "state_eq"=>"完了")
    task = task.result(distinct: true)
    expect(task.empty?).to eq true
  end

  it 'State"完了"で検索される' do
    Task.create(subject: '成功テスト', content: '成功テスト', expired_at: Time.current, state: '完了', user_id: User.first.id)
    task = Task.search_ransack("subject_cont"=>"", "state_eq"=>"完了")
    task = task.result(distinct: true)
    expect(task.empty?).to eq false
  end

  it 'Subject"成功"で検索されない' do
    Task.create(subject: '失敗テスト', content: '失敗テスト', expired_at: Time.current, user_id: User.first.id)
    task = Task.search_ransack("subject_cont"=>"成功")
    task = task.result(distinct: true)
    expect(task.empty?).to eq true
  end

  it 'Subject"成功"で検索される' do
    Task.create(subject: '成功テスト', content: '成功テスト', expired_at: Time.current, user_id: User.first.id)
    task = Task.search_ransack("subject_cont"=>"成功")
    task = task.result(distinct: true)
    expect(task.empty?).to eq false
  end

  it 'Subject"成功"且つState"完了"で検索されない_Subjectが誤り' do
    Task.create(subject: '失敗テスト', content: '失敗テスト', expired_at: Time.current, state: '完了', user_id: User.first.id)
    task = Task.search_ransack("subject_cont"=>"成功", "state_eq"=>"完了")
    task = task.result(distinct: true)
    expect(task.empty?).to eq true

  end

  it 'Subject"成功"且つState"完了"で検索されない_Stateが誤り' do
    Task.create(subject: '成功テスト', content: '成功テスト', expired_at: Time.current, state: '未着手', user_id: User.first.id)
    task = Task.search_ransack("subject_cont"=>"", "state_eq"=>"完了")
    task = task.result(distinct: true)
    expect(task.empty?).to eq true
  end

  it 'Subject"成功"且つState"完了"で検索される' do
    Task.create(subject: '成功テスト', content: '成功テスト', expired_at: Time.current, state: '完了', user_id: User.first.id)
    task = Task.search_ransack("subject_cont"=>"", "state_eq"=>"完了")
    task = task.result(distinct: true)
    expect(task.empty?).to eq false
  end

  it 'stateの値がnilでも、defaltの値が入るため、NotNull制約違反にならない' do
    task = Task.new(subject: '失敗テスト', content: '失敗テスト', expired_at: Time.current, state: nil, user_id: User.first.id)
    expect(task).to be_valid
  end

  it 'priorityの値がnilでも、defaltの値が入るため、NotNull制約違反にならない' do
    task = Task.new(subject: '失敗テスト', content: '失敗テスト', expired_at: Time.current, priority: nil, user_id: User.first.id)
    expect(task).to be_valid
  end
end