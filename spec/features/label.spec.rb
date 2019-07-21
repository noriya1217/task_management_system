require 'rails_helper'

RSpec.feature 'タスク管理システム(label)', type: :feature do

  background do
    FactoryBot.create(:user)
    FactoryBot.create(:admin)
    FactoryBot.create(:task)
    FactoryBot.create(:label)
    FactoryBot.create(:second_label)
    FactoryBot.create(:labeling)
    FactoryBot.create(:second_labeling)
    FactoryBot.create(:user_label)
    FactoryBot.create(:second_user_label)
    FactoryBot.create(:user_labeling)
    FactoryBot.create(:second_user_labeling)
    visit root_path
    fill_in 'session_email', with: 'hoge@example.com'
    fill_in 'session_password', with: 'password'
    fill_in 'session_password_confirmation', with: 'password'
    click_button 'ログイン'
  end

  scenario '管理者のみ作成できる共通ラベルを選択して、タスクを作成する' do
    click_link 'タスクを新規登録する'
    fill_in 'task_subject', with: '共有ラベルをつけてタスクを作成する'
    fill_in 'task_content', with: 'テストを成功させる'
    check 'task_label_ids_1'
    click_button '登録する'
    expect(page).to have_content '新しいタスクを作成しました'
    expect(all('tr')[1]).to have_content 'Ruby'
  end

  scenario '各ユーザ固有のラベルを選択して、タスクを作成する' do
    click_link 'タスクを新規登録する'
    fill_in 'task_subject', with: 'ユーザ固有のラベルをつけてタスクを作成する'
    fill_in 'task_content', with: 'テストを成功させる'
    check 'task_user_label_ids_3'
    check 'task_user_label_ids_4'
    click_button '登録する'
    expect(page).to have_content '新しいタスクを作成しました'
    expect(all('tr')[1]).to have_content 'Vue.js'
    expect(all('tr')[1]).to have_content 'React'
  end

  scenario '管理者のみ作成できる共有ラベルと、各ユーザが作成できる固有ラベルを両方選択して、タスクを作成する' do
    click_link 'タスクを新規登録する'
    fill_in 'task_subject', with: '共通ラベルとユーザ固有のラベルをつけてタスクを作成する'
    fill_in 'task_content', with: 'テストを成功させる'
    check 'task_label_ids_5'
    check 'task_label_ids_6'
    check 'task_user_label_ids_5'
    check 'task_user_label_ids_6'
    click_button '登録する'
    expect(all('tr')[1]).to have_content '共通ラベルとユーザ固有のラベルをつけてタスクを作成する'
    expect(all('tr')[1]).to have_content 'テストを成功させる'
    expect(all('tr')[1]).to have_content 'Ruby'
    expect(all('tr')[1]).to have_content 'Python'
    expect(all('tr')[1]).to have_content 'Vue.js'
    expect(all('tr')[1]).to have_content 'React'
  end

  scenario 'タスクを編集しラベルを付け替える' do
    expect(page).to have_content 'Ruby'
    expect(page).to have_content 'Vue.js'
    all('tr')[1].click_link '編集'
    uncheck 'task_label_ids_7'
    uncheck 'task_user_label_ids_7'
    click_button '更新する'
    expect(page).not_to have_content 'Ruby'
    expect(page).not_to have_content 'Vue.js'
  end

  scenario '共有のラベルを新規作成する' do
    visit new_admin_label_path
    fill_in 'label_name', with: '共有ラベル'
    click_button 'ラベル登録する'
    expect(page).to have_content 'ラベルを作成しました'
    expect(page).to have_content '共有ラベル'
  end

  scenario '共有のラベルを編集する' do
    visit admin_labels_path
    all('tr')[1].click_link '編集'
    fill_in 'label_name', with: '共有ラベル編集'
    click_button 'ラベル更新する'
    expect(page).to have_content 'ラベルを編集しました'
    expect(page).to have_content '共有ラベル編集'
  end

  scenario '各ユーザ固有のラベルを作成する' do
    visit new_label_path
    fill_in 'user_label_name', with: '固有ラベル'
    click_button 'ラベル登録する'
    expect(page).to have_content 'ラベルを作成しました'
    expect(page).to have_content '固有ラベル'
  end

  scenario '各ユーザ固有のラベルを編集する' do
    visit labels_path
    all('tr')[1].click_link '編集'
    fill_in 'user_label_name', with: '固有ラベル編集'
    click_button 'ラベル更新する'
    expect(page).to have_content 'ラベルを編集しました'
    expect(page).to have_content '固有ラベル編集'
  end

  scenario 'タスク一覧の検索に、共通ラベルのプルダウンが表示されている事を確認' do
    expect(page).to have_select('q_labels_id_eq', options: ['指定無し', 'Ruby', 'Python'])
  end

  scenario 'タスク一覧の検索に、現在ログインしているユーザの固有ラベルのプルダウンが表示されている事を確認' do
    expect(page).to have_select('q_user_labels_id_eq', options: ['指定無し', 'Vue.js', 'React'])
  end

  scenario 'タスク一覧に共有ラベルだけ表示されている事を確認' do
    FactoryBot.create(:second_user)
    expect(page).to have_content 'Ruby'
    expect(page).to have_content 'Python'
    expect(page).to have_content 'Vue.js'
    expect(page).to have_content 'React'
    click_link 'Logout'
    fill_in 'session_email', with: 'piyo@example.com'
    fill_in 'session_password', with: 'piyopiyo'
    fill_in 'session_password_confirmation', with: 'piyopiyo'
    click_button 'ログイン'
    expect(page).to have_content 'Ruby'
    expect(page).to have_content 'Python'
    expect(page).not_to have_content 'Vue.js'
    expect(page).not_to have_content 'React'
  end

  scenario 'タスク一覧に共通ラベルと固有ラベルが表示されている事を確認' do
    expect(page).to have_content 'Ruby'
    expect(page).to have_content 'Python'
    expect(page).to have_content 'Vue.js'
    expect(page).to have_content 'React'
  end

  scenario 'タスク新規作成時に、あるユーザが作成した固有ラベルを他のユーザが使用することが出来ない事を確認' do
    FactoryBot.create(:second_user)
    expect(page).to have_content 'Ruby'
    expect(page).to have_content 'Python'
    expect(page).to have_content 'Vue.js'
    expect(page).to have_content 'React'
    click_link 'Logout'
    fill_in 'session_email', with: 'piyo@example.com'
    fill_in 'session_password', with: 'piyopiyo'
    fill_in 'session_password_confirmation', with: 'piyopiyo'
    click_button 'ログイン'
    click_link 'タスクを新規登録する'
    expect(page).to have_content 'Ruby'
    expect(page).to have_content 'Python'
    expect(page).not_to have_content 'Vue.js'
    expect(page).not_to have_content 'React'
  end

  scenario 'タスク編集時に、あるユーザが作成した固有ラベルを他のユーザが使用することが出来ない事を確認' do
    FactoryBot.create(:second_user)
    expect(page).to have_content 'Ruby'
    expect(page).to have_content 'Python'
    expect(page).to have_content 'Vue.js'
    expect(page).to have_content 'React'
    click_link 'Logout'
    fill_in 'session_email', with: 'piyo@example.com'
    fill_in 'session_password', with: 'piyopiyo'
    fill_in 'session_password_confirmation', with: 'piyopiyo'
    click_button 'ログイン'
    all('tr')[1].click_link '編集'
    expect(page).to have_content 'Ruby'
    expect(page).to have_content 'Python'
    expect(page).not_to have_content 'Vue.js'
    expect(page).not_to have_content 'React'
  end

end