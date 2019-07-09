require 'rails_helper'

RSpec.feature 'タスク管理システム(task)', type: :feature do

  background do
    # FactoryBot.create(:user)
    # FactoryBot.create(:task)
    # FactoryBot.create(:second_task)
    # FactoryBot.create(:third_task)
    # page.driver.browser.authorize('hoge', 'piyo')
    # visit root_path
    # fill_in 'session_email', with: 'hoge@example.com'
    # fill_in 'session_password', with: 'password'
    # fill_in 'session_password_confirmation', with: 'password'
    # click_button 'ログイン'
  end

  scenario 'タスク新規作成と編集をする時に、あるユーザが作成したラベルを他のユーザが使用することが出来ない事を確認' do

  end

  scenario '管理者のみ作成できるラベルを選択して、タスクを作成する' do

  end

  scenario '各ユーザが作成できるラベルを選択して、タスクを作成する' do

  end

  scenario '管理者のみ作成できるラベルと、各ユーザが作成できるラベルを両方選択して、タスクを作成する' do

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