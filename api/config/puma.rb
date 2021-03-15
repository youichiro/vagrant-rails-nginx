max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# rails_env = ENV.fetch("RAILS_ENV") { "development" }
environment ENV.fetch("RAILS_ENV") { "development" }

port ENV.fetch("PORT") { 3000 }

# if rails_env == 'production'
#   bind "unix://#{Rails.root}/tmp/sockets/puma.sock"
# elsif
#   port ENV.fetch("PORT") { 3000 }
# end

plugin :tmp_restart
