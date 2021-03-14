environment "production"
bind "unix://#{Rails.root}/tmp/sockets/puma.sock"
daemonize
