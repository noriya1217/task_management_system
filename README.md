# タスク管理システム　テーブル表

|user||
|:--|:--|
|id||
|name|string|
|email|string|
|password_digest|string|
|admin|boolean|

---

|task||
|:--|:--|
|id||
|user_id|integer|
|subject|string|
|priority|string|
|status|string|
|person_in_charge|string|
|start_date|datetime|
|end_date|datetime|
|deadline|datetime|
|achievement_rate|integer|

---

|label||
|:--|:--|
|id||
|task_id|integer|
|name|string|

プルリクエスト作成を促すバーを出現させるためだけの追加行