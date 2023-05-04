###  ユーザ (user)

| カラム名        | データ型    |
| --------------- | ----------- |
| id              | integer     |
| name            | string      |
| email           | string      |
| password_digest | string      |
### タスク (task)

| カラム名 | データ型 |
| -------- | -------- |
| id       | integer  |
| user_id  | bigint   |
| title    | string   |
| content  | text     |
| deadline | date     |
| priority | integer  |
| status   | integer  |
### ラベル (label)

| カラム名 | データ型 |
| -------- | -------- |
| id       | integer  |
| name     | string   |

### タスクラベル (task_label)

| カラム名   | データ型  |
| ---------- | --------- |
| id         | integer   |
| task_id    | integer   |
| label_id   | integer   |
