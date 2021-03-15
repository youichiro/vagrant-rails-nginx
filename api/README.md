## log

```bash
$ rails new . -d mysql -T --api
```

condif/database.yml

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

config/application.rb

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

config/puma.rb

```diff
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

environment ENV.fetch("RAILS_ENV") { "development" }

port ENV.fetch("PORT") { 3000 }


plugin :tmp_restart
```


