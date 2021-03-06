require 'rails_helper'

RSpec.describe User, type: :model do
  it 'nameの値がnilならNotNull制約違反になる' do
    user = User.new(
                    name: nil,
                    email: 'failure_test@example.com',
                    password: 'password',
                    password_confirmation: 'password',
                    )
    expect(user).not_to be_valid
  end

  it 'emailの値がnilならNotNull制約違反になる' do
    user = User.new(
                    name: 'tanaka',
                    email: nil,
                    password: 'password',
                    password_confirmation: 'password',
                    )
    expect(user).not_to be_valid
  end

  it 'passwordの値がnilならNotNull制約違反になる' do
    user = User.new(
                    name: 'tanaka',
                    email: 'failure_test@example.com',
                    password: nil,
                    password_confirmation: nil,
                    )
    expect(user).not_to be_valid
  end

  it 'nameが空白の場合、バリデーションが通らない' do
    user = User.new(
                    name: '',
                    email: 'failure_test@example.com',
                    password: 'password',
                    password_confirmation: 'password',
                    )
    expect(user).not_to be_valid
  end

  it 'nameが20文字を超過した場合、バリデーションが通らない' do
    user = User.new(
                    name: 'a'*21,
                    email: 'failure_test@example.com',
                    password: 'password',
                    password_confirmation: 'password',
                    )
    expect(user).not_to be_valid
  end

  it 'emailが空白の場合、バリデーションが通らない' do
    user = User.new(
                    name: 'tanaka',
                    email: '',
                    password: 'password',
                    password_confirmation: 'password',
                    )
    expect(user).not_to be_valid
  end

  it 'emailが255文字を超過した場合、バリデーションが通らない' do
    user = User.new(
                    name: 'tanaka',
                    email: ('a'*252) + '@a.a',
                    password: 'password',
                    password_confirmation: 'password',
                    )
    expect(user).not_to be_valid
  end

  it '同じemailが既に登録されていた場合、バリデーションが通らない' do
    user = User.new(
                    name: 'tanaka',
                    email: 'failure_test@example.com',
                    password: 'password',
                    password_confirmation: 'password',
                    )
    user.save
    user = User.new(
                    name: 'tanaka',
                    email: 'failure_test@example.com',
                    password: 'password',
                    password_confirmation: 'password',
                    )
    expect(user).not_to be_valid
  end

  it 'emailが"a@b.c"の形式以外の場合、バリデーションが通らない' do
    user = User.new(
                    name: 'tanaka',
                    email: 'a',
                    password: 'password',
                    password_confirmation: 'password',
                    )
    expect(user).not_to be_valid

    user = User.new(
                    name: 'tanaka',
                    email: '@a.a',
                    password: 'password',
                    password_confirmation: 'password',
                    )
    expect(user).not_to be_valid
    
    user = User.new(
                    name: 'tanaka',
                    email: 'a.a',
                    password: 'password',
                    password_confirmation: 'password',
                    )
    expect(user).not_to be_valid
  end

  it 'passwordが空白の場合、バリデーションが通らない' do
    user = User.new(
                    name: 'tanaka',
                    email: 'failure_test@example.com',
                    password: '',
                    password_confirmation: '',
                    )
    expect(user).not_to be_valid
  end

  it 'passwordが６文字未満の場合、バリデーションが通らない' do
    user = User.new(
                    name: 'tanaka',
                    email: 'failure_test@example.com',
                    password: '12345',
                    password_confirmation: '12345',
                    )
    expect(user).not_to be_valid
  end

  it 'passwordが一致しない場合、バリデーションが通らない' do
    user = User.new(
                    name: 'tanaka',
                    email: 'failure_test@example.com',
                    password: '123456',
                    password_confirmation: 'abcdef',
                    )
    expect(user).not_to be_valid
  end

  it 'name,email,passwordが正しく入力されている場合バリデーションが通る' do
    user = User.new(
                    name: 'tanaka',
                    email: 'failure_test@example.com',
                    password: 'password',
                    password_confirmation: 'password',
                    )
    expect(user).to be_valid
  end

end
