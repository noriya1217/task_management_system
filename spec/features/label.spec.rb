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
    # FactoryBot.create(:second_task)
    # FactoryBot.create(:third_task)
    page.driver.browser.authorize('hoge', 'piyo')
    visit root_path
    fill_in 'session_email', with: 'hoge@example.com'
    fill_in 'session_password', with: 'password'
    fill_in 'session_password_confirmation', with: 'password'
    click_button 'ログイン'
  end

  scenario '管理者のみ作成できるラベルを選択して、タスクを作成する' do
    click_link 'タスクを新規登録する'
    fill_in 'task_subject', with: '共通ラベルをつけてタスクを作成する'
    fill_in 'task_content', with: 'テストを成功させる'
    check 'task_label_ids_1'
    click_button '登録する'
    expect(page).to have_content '新しいタスクを作成しました'
    expect(all('tr')[1]).to have_content 'Ruby'
    # save_and_open_page
  end
  
  scenario '各ユーザが作成できるラベルを選択して、タスクを作成する' do
    
  end
  
  scenario '管理者が作成できるラベルを編集する' do
    
  end
  
  scenario '各ユーザが作成できるラベルを編集する' do
    
  end
  
  scenario '管理者のみ作成できるラベルと、各ユーザが作成できるラベルを両方選択して、タスクを作成する' do
    
  end

  scenario 'タスク新規作成と編集をする時に、あるユーザが作成したラベルを他のユーザが使用することが出来ない事を確認' do

  end

  scenario 'タスク一覧の検索に現在ログインしているユーザが作成したラベルのプルダウンが表示されている事を確認' do

  end

  scenario 'タスク一覧に管理者のみ作成できるラベルが表示されている事を確認' do

  end

  scenario 'タスク一覧に各ユーザが作成できるラベルが表示されている事を確認' do

  end
  
  scenario '' do

  end

end