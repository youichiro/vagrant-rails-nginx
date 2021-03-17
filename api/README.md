# LOG
Railsアプリケーションの作成・設定の変更ログを残す

## プロジェクトの作成

```bash
$ rails new . -d mysql -T --api
```

## DBの設定

`condif/database.yml`

```diff
  default: &default
    adapter: mysql2
    encoding: utf8mb4
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
    username: root
    password:
-   host: localhost
+   host: <%= ENV.fetch("MYSQL_HOST") { "localhost" } %>
+   port: <%= ENV.fetch("MYSQL_POST") { 3306 } %>

  development:
    <<: *default
    database: api_development

  test:
    <<: *default
    database: api_test

  production:
    <<: *default
    database: api_production
-   username: backend
-   password: <%= ENV["API_DATABASE_PASSWORD"] %>
+   username: <%= ENV.fetch("API_DATABASE_USER") %>
+   password: <%= ENV.fetch("API_DATABASE_PASSWORD") %>
```

## scaffoldの実行

```bash
$ docker-compose exec api bin/rails g scaffold user name:string -T
```


## DBの初期コマンド

```bash
# 開発環境
$ docker-compose exec api bin/rails db:create
$ docker-compose exec api bin/rails db:migrate
$ docker-compose exec api bin/rails db:seed

# 本番環境
$ docker-compose -f docker-compose.prod.yml exec api bin/rails db:migrate
$ docker-compose -f docker-compose.prod.yml exec api bin/rails db:seed
```

## 許可するホストの指定
アクセスを許可するホストを指定する必要がある

`config/application.rb`

```diff
  // ...

  module Backend
    class Application < Rails::Application
      config.load_defaults 6.1
      config.api_only = true

+     config.hosts << 'api.example.com'
    end
  end
```

## pumaの設定
develomentモードなら3000番ポートで起動し、productionモードならソケットで起動する

`config/puma.rb`

```diff
  max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
  min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
  threads min_threads_count, max_threads_count

  pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

- environment ENV.fetch("RAILS_ENV") { "development" }
+ rails_env = ENV.fetch("RAILS_ENV") { "development" }
+ environment rails_env

- port ENV.fetch("PORT") { 3000 }
+ if rails_env == 'production'
+   bind "unix://#{Rails.root}/tmp/sockets/puma.sock"
+ elsif
+   port ENV.fetch("PORT") { 3000 }
+ end

  plugin :tmp_restart
```
