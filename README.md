# タスク管理システム

## Basic認証のユーザー名とパスワード

    ユーザー名　：　hoge
    パスワード　：　piyo

---

## テーブル表

|admin  |   |user           |       |task            |        |label  |       |
|:--    |:--|:--            |:--    |:--             |:--     |:--    |:--    |
|id     |   |id             |       |id              |        |id     |       |
|user_id|   |name           |string |user_id         |integer |task_id|integer|
|       |   |email          |string |subject         |string  |name   |string |
|       |   |password_digest|string |content         |string  |
|       |   |               |       |priority        |string  |
|       |   |               |       |status          |string  |
|       |   |               |       |person_in_charge|string  |
|       |   |               |       |start_date_at   |datetime|
|       |   |               |       |end_date_at     |datetime|
|       |   |               |       |expired_at      |datetime|
|       |   |               |       |achievement_rate|integer |

---

## フレームワーク等のバージョン

- Ruby 2.6.3
- Rails 5.2.3
- PostgreSQL 11.3

---

## Herokuへのデプロイ、操作等

1. 基本
    ```rb
    $ heroku create
    $ rails assets:precompile RAILS_ENV=production
    $ git add -A
    $ git commit -m "commit comment"
    $ git push heroku master
    $ heroku run rails db:migrate
    ```

1. 開発ブランチ（develop）をherokuのmasterブランチにpushする

    `$ git push heroku develop:master`

1. リアルタイムでログ確認

    `$ heroku logs -t`

1. コンソール確認

    `$ heroku run rails console`

1. Heroku再起動

    `$ heroku restart`

1. Herokuデータベースリセット

    `$ heroku pg:reset DATABASE`
