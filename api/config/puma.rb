max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

environment ENV.fetch("RAILS_ENV") { "development" }

port ENV.fetch("PORT") { 3000 }


plugin :tmp_restart
