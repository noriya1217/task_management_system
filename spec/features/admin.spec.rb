require 'rails_helper'

RSpec.feature 'タスク管理システム(admin)', type: :feature do

  background do
    FactoryBot.create(:user)
    FactoryBot.create(:admin)
    page.driver.browser.authorize('hoge', 'piyo')
    visit root_path
    fill_in 'session_email', with: 'hoge@example.com'
    fill_in 'session_password', with: 'password'
    fill_in 'session_password_confirmation', with: 'password'
    click_button 'ログイン'
    click_link 'Admin'
  end

  scenario '管理権限が無いユーザーが管理画面に遷移できない事を確認するテスト' do
    FactoryBot.create(:second_user)
    click_link 'Logout'
    fill_in 'session_email', with: 'piyo@example.com'
    fill_in 'session_password', with: 'piyopiyo'
    fill_in 'session_password_confirmation', with: 'piyopiyo'
    click_button 'ログイン'
    expect(page).not_to have_content 'Admin'
  end

  scenario '管理権限が有るユーザーが管理画面に遷移できる事を確認するテスト＆ユーザー一覧表示テスト' do
    click_link 'Admin'
    expect(page).to have_content '管理画面'
    expect(page).to have_content 'hoge'
    expect(page).to have_content 'hoge@example.com'
  end

  scenario 'ユーザー新規作成テスト' do
    click_link 'ユーザーを新規登録する'
    fill_in 'user_name', with: 'tanaka'
    fill_in 'user_email', with: 'tarou@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'アカウント登録する'
    expect(page).to have_content 'アカウント作成しました'
    expect(page).to have_content 'tanaka'
    expect(page).to have_content 'tarou@example.com'
  end

  scenario 'ユーザー詳細のテスト' do
    all('tr')[1].click_link '詳細'
    expect(page).to have_content 'hoge@example.com'
  end

  scenario 'ユーザー編集のテスト' do
    all('tr')[1].click_link '編集'
    fill_in 'user_name', with: 'sasaki'
    fill_in 'user_email', with: 'kensuke@nifty.com'
    fill_in 'user_password', with: 'editedit'
    fill_in 'user_password_confirmation', with: 'editedit'
    click_button 'アカウント更新する'
    expect(page).to have_content 'sasaki'
    expect(page).to have_content 'kensuke@nifty.com'
  end

  scenario 'ユーザー削除のテスト' do
    FactoryBot.create(:second_user)
    click_link 'Admin'
    # ログインしていないユーザーを削除
    all('tr')[2].click_link '削除'
    expect(page).not_to have_content 'piyo'
    expect(page).not_to have_content 'piyo@example.com'
    expect(page).to have_content 'ユーザーを削除しました'
    # ログインしているユーザーを削除
    all('tr')[1].click_link '削除'
    expect(page).to have_content 'ログイン画面'
  end

  scenario 'ユーザー一覧にユーザー毎のタスク数表示されているかテスト' do
    FactoryBot.create(:second_user)
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:fourth_task)
    click_link 'Admin'
    # テーブルには数値を入れている項目が複数あるため、tdを取得
    tds = page.all('td')
    expect(tds[7]).to have_content '3'
    expect(tds[14]).to have_content '1'
  end

  scenario 'ユーザーが作成したタスク一覧が詳細画面に表示されているかテスト' do
    FactoryBot.create(:task)
    all('tr')[1].click_link '詳細'
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
  end
end