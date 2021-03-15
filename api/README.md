## rails new

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
-  host: localhost
+  host: <%= ENV.fetch("MYSQL_HOST") { "localhost" } %>
+  port: <%= ENV.fetch("MYSQL_POST") { 3306 } %>

 development:
   <<: *default
   database: backend_development

 test:
   <<: *default
   database: backend_test

 production:
   <<: *default
   database: backend_production
-  username: backend
+  username: root
-  password: <%= ENV['BACKEND_DATABASE_PASSWORD'] %>
+  password:
```

## DBを作成

```bash
$ docker-compose run --rm api bin/rails db:create
$ docker-compose run --rm -e RAILS_ENV=production api bin/rails db:create
```

## 許可するホストを指定

`config/application.rb`

```diff
 // ...

 module Backend
   class Application < Rails::Application
     config.load_defaults 6.1
     config.api_only = true

+    config.hosts << 'api'
+    config.hosts << 'api.example.com'
   end
 end
```

## pumaの設定

`config/puma.rb`

```diff
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

environment ENV.fetch("RAILS_ENV") { "development" }

port ENV.fetch("PORT") { 3000 }


plugin :tmp_restart
```

## scaffold

```bash
$ docker-compose run --rm api bin/rails g scaffold user name:string -T
$ docker-compose run --rm api bin/rails db:migrate
$ docker-compose run --rm -e RAILS_ENV=production api bin/rails db:migrate

$ docker-compose run --rm api bin/rails db:seed
$ docker-compose run --rm -e RAILS_ENV=production api bin/rails db:seed
```
