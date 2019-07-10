require 'rails_helper'

RSpec.feature 'タスク管理システム(user/session)', type: :feature do

  background do
    FactoryBot.create(:user)
    page.driver.browser.authorize('hoge', 'piyo')
  end

  scenario 'アカウント作成のテスト' do
    visit root_path
    click_link 'Sign up'
    fill_in 'user_name', with: 'tanaka'
    fill_in 'user_email', with: 'tanaka@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'アカウント登録する'
    expect(page).to have_content 'アカウント作成しました'
  end

  scenario 'ログイン/ログアウトのテスト' do
    visit root_path
    fill_in 'session_email', with: 'hoge@example.com'
    fill_in 'session_password', with: 'password'
    fill_in 'session_password_confirmation', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
    click_link 'Logout'
    expect(page).to have_content 'ログアウトしました'
  end

  scenario '未ログイン時にTaskページに直リンクで飛ぶとログイン画面に遷移するテスト' do
    visit tasks_path
    expect(page).to have_content 'このセクションにアクセスするにはログインして下さい'
  end

  scenario 'ログイン時にユーザー登録画面及びログイン画面に遷移できない事を確認するテスト' do
    visit root_path
    fill_in 'session_email', with: 'hoge@example.com'
    fill_in 'session_password', with: 'password'
    fill_in 'session_password_confirmation', with: 'password'
    click_button 'ログイン'
    visit new_user_path
    expect(page).to have_content 'このセクションにアクセスするにはログアウトして下さい'
    visit new_session_path
    expect(page).to have_content 'このセクションにアクセスするにはログアウトして下さい'
  end

  scenario '現在ログインしているユーザー以外のマイページに遷移できないことを確認するテスト' do
    FactoryBot.create(:second_user)
    visit root_path
    fill_in 'session_email', with: 'hoge@example.com'
    fill_in 'session_password', with: 'password'
    fill_in 'session_password_confirmation', with: 'password'
    click_button 'ログイン'
    visit user_path(User.last.id)
    expect(page).to have_content '他ユーザーのProfileは閲覧出来ません'
  end

end