# タスク管理システム

## バージョン

- Ruby 2.6.3
- Rails 5.2.3
- PostgreSQL 11.3

## 機能一覧

1. ログイン機能
1. ユーザー登録
1. プロフィール編集機能
1. タスク一覧機能
    - カレンダーの中に終了期限日のタスク表示
    - ページネーション
    - 検索機能
1. Admin管理機能

## 使用Gem

### 本番

- bootstrap
- kaminari
- ransack
- simple_calendar

### 開発 / テスト

- better_errors
- binding_of_caller
- capybara
- database_cleaner
- factory_bot_rails
- faker
- pry-rails
- rspec-rails
- rubocop
- spring-commands-rspec