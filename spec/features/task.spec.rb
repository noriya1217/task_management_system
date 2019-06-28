require 'rails_helper'

RSpec.feature 'タスク管理システム', type: :feature do

  background do
    FactoryBot.create(:user)
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    page.driver.browser.authorize('hoge', 'piyo')
    visit root_path
    fill_in 'session_email', with: 'hoge@example.com'
    fill_in 'session_password', with: 'password'
    fill_in 'session_password_confirmation', with: 'password'
    click_button 'ログイン'
  end

  scenario 'タスク一覧のテスト' do
    visit tasks_path
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario 'タスク作成のテスト' do
    visit new_task_path
    fill_in 'Subject', with: 'タスクの件名を入力する'
    fill_in 'Content', with: 'タスクの内容を入力する'

    click_button '登録する'
    expect(page).to have_content 'タスクの件名を入力する'
    expect(page).to have_content 'タスクの内容を入力する'
  end

  scenario 'タスク詳細のテスト' do
    visit tasks_path
    all('tr')[1].click_link '詳細'
    expect(page).to have_content 'hogehogehoge'
  end

  scenario 'タスク編集のテスト' do
    visit tasks_path
    all('tr')[1].click_link '編集'
    fill_in 'Subject', with: 'test_task_edit'
    fill_in 'Content', with: 'test_edit_content'
    click_button '更新する'

    expect(page).to have_content 'test_task_edit'
    expect(page).to have_content 'test_edit_content'
  end

  scenario 'タスク削除のテスト' do
    visit tasks_path
    all('tr')[1].click_link '削除'
    expect(page).to have_no_content 'test_task_03'
    expect(page).to have_no_content 'hogehogehoge'
  end

  scenario 'タスクが作成日時の降順に並んでいるかのテスト' do
    visit tasks_path
    trs = page.all('tr')
    # テーブル最初の行には、'Subject'と'Content'が入っているため、最初のレコードが入るのは2行目から
    expect(trs[1]).to have_content 'test_task_03'
    expect(trs[1]).to have_content 'hogehogehoge'
  end

  scenario 'タスクが終了期限の降順に並んでいるかのテスト' do
    visit new_task_path
    fill_in 'Subject', with: '終了期限テスト新規2021年'
    fill_in 'Content', with: '終了期限テスト新規2021年'
    select '2021', from: 'task[expired_at(1i)]'
    click_button '登録する'

    # 新規作成したデータを残しておき、既存レコードの終了期限を新規データより後に編集する
    all('tr')[2].click_link '編集'
    fill_in 'Subject', with: '終了期限テスト編集2022年'
    fill_in 'Content', with: '終了期限テスト編集2022年'
    select '2022', from: 'task[expired_at(1i)]'
    click_button '更新する'

    click_link '一覧'
    click_link 'タスクを終了期限順に並び替える'

    trs = page.all('tr')
    # テーブル最初の行には、'Subject'と'Content'が入っているため、最初のレコードが入るのは2行目から
    expect(trs[1]).to have_content '終了期限テスト編集2022年'
    expect(trs[2]).to have_content '終了期限テスト新規2021年'
  end

  scenario 'タスクのSubjectを検索するテスト' do
    visit tasks_path
    fill_in 'q_subject_cont', with: '01'
    click_button 'Search'
    expect(page).to have_content 'test_task_01'
    expect(page).to have_no_content 'test_task_02'
  end

  scenario 'タスクのStateを検索するテスト' do
    visit tasks_path
    all('tr')[1].click_link '編集'
    choose 'task_state_完了'
    click_button '更新する'
    click_link '一覧'
    select '完了', from: 'q_state_eq'
    click_button 'Search'
    expect(page).to have_content 'test_task_03'
    expect(page).to have_no_content 'test_task_02'
    expect(page).to have_no_content 'test_task_01'
  end

  scenario 'タスクのSubjectとStateをAND検索するテスト' do
    visit tasks_path
    all('tr')[1].click_link '編集'
    choose 'task_state_着手中'
    click_button '更新する'
    click_link '一覧'
    all('tr')[2].click_link '編集'
    choose 'task_state_着手中'
    click_button '更新する'
    click_link '一覧'

    fill_in 'q_subject_cont', with: '02'
    select '着手中', from: 'q_state_eq'
    click_button 'Search'

    expect(page).to have_content 'test_task_02'
    expect(page).to have_no_content 'test_task_03'
  end

  scenario 'タスクの優先度を、高中低の順に並び替えるテスト(link_to)' do
    visit tasks_path
    all('tr')[2].click_link '編集'
    choose 'task_priority_high'
    click_button '更新する'
    click_link '一覧'
    all('tr')[3].click_link '編集'
    choose 'task_priority_low'
    click_button '更新する'
    click_link '一覧'
    click_link 'タスクを優先度順に並び替える'
    trs = page.all('tr')
    # テーブル最初の行には、ラベルが入っているため、最初のレコードが入るのは2行目から
    expect(trs[1]).to have_content 'high'
    expect(trs[2]).to have_content 'middle'
    expect(trs[3]).to have_content 'low'
  end

  scenario 'タスクの優先度を、高中低の順に並び替えるテスト(Ransack)' do
    visit tasks_path
    all('tr')[2].click_link '編集'
    choose 'task_priority_high'
    click_button '更新する'
    click_link '一覧'
    all('tr')[3].click_link '編集'
    choose 'task_priority_low'
    click_button '更新する'
    click_link '一覧'
    click_link 'Priority'
    trs = page.all('tr')
    expect(trs[1]).to have_content 'high'
    expect(trs[2]).to have_content 'middle'
    expect(trs[3]).to have_content 'low'
  end

  scenario 'タスクの優先度を、低中高の順に並び替えるテスト(Ransack)' do
    visit tasks_path
    all('tr')[2].click_link '編集'
    choose 'task_priority_high'
    click_button '更新する'
    click_link '一覧'
    all('tr')[3].click_link '編集'
    choose 'task_priority_low'
    click_button '更新する'
    click_link '一覧'
    click_link 'Priority'
    click_link 'Priority'
    trs = page.all('tr')
    expect(trs[1]).to have_content 'low'
    expect(trs[2]).to have_content 'middle'
    expect(trs[3]).to have_content 'high'
  end

  scenario 'タスク一覧のページネーションテスト(kaminari)' do
    Task.create!(subject: "成功テスト", content: "成功テスト", user_id: User.first.id)
    10.times do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
      FactoryBot.create(:third_task)
    end
    visit tasks_path
    click_link '»' # ページネーションの最後
    trs = page.all('tr')
    # backgroundにて最後から３つのデータは既に作成されているため
    expect(trs[trs.length - 4]).to have_content '成功テスト'
  end

end