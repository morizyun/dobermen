worker_processes 2

pid File.expand_path('tmp/pids/unicorn.pid', ENV['RAILS_ROOT']).to_s
listen 3000

stderr_path File.expand_path('log/error.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/development.log', ENV['RAILS_ROOT'])

preload_app true

before_fork do |_server, _worker|
  ENV['BUNDLE_GEMFILE'] = "#{ENV['RAILS_ROOT']}/Gemfile"
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end