herokuへデプロイの手順
-  heroku login
-  heroku create
-  Gemfileにgem 'net-smtp', gem 'net-imap', gem 'net-pop'追加し、
-  bundle install
-  heroku buildpacks:set heroku/ruby
-  heroku buildpacks:add --index 1 heroku/nodejs
-  bundle lock --add-platform x86_64-linux
-  heroku stack:set heroku-20
-  heroku run rails db:migrate
-  git add .
-  git commit -m "init"
-  git push heroku master
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
