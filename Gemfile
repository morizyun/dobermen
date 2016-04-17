source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta3', '< 5.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.x'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# ============================
# View
# ============================
# Bootstrap & Bootswatch & font-awesome
gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'font-awesome-rails'

# Fast Haml
gem 'haml-rails'

# Form Builders
gem 'simple_form'

# Pagenation
gem 'kaminari'

# ============================
# Utils
# ============================
# Process Management
gem 'foreman'

# Hash extensions
gem 'hashie'

# Presenter Layer Helper
gem 'cells'
gem 'cells-haml'

# Table(Migration) Comment
gem 'migration_comments'

# Exception Notifier
gem 'exception_notification'

# Embed the V8 Javascript Interpreter
gem 'therubyracer'

# GitLab API Wrapper
gem 'gitlab'

# configuration using ENV
gem 'figaro'

# A static analysis security vulnerability scanner
gem 'brakeman'

# Universal capture of stdout and stde
gem 'systemu'

# Simple and safe way to dynamically render error pages
gem 'rambulance'

# ============================
# Environment Group
# ============================
group :development do
  gem 'erb2haml'

  # help to kill N+1
  gem 'bullet'

  # Rack Profiler
  # gem 'rack-mini-profiler'
end

group :development, :test do
  # App Server
  gem 'puma'

  # Pry & extensions
  gem 'pry-rails'
  gem 'pry-coolline'
  gem 'pry-byebug'
  gem 'rb-readline'

  # Show SQL result in Pry console
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'awesome_print'

  # PG/MySQL Log Formatter
  gem 'rails-flog'

  # Assets log cleaner
  gem 'quiet_assets'

  # Rspec
  gem 'rspec-rails'

  # test fixture
  gem 'factory_girl_rails'
end

group :test do
  # Mock for HTTP requests
  gem 'webmock'
  gem 'vcr'

  # Time Mock
  gem 'timecop'

  # Support to generate Test Data
  gem 'faker'

  # Cleaning test data
  gem 'database_rewinder'

  # This gem brings back assigns to your controller tests
  gem 'rails-controller-testing'
end

group :production do
  # For Heroku / Dokku
  gem 'rails_12factor'

  # App Server
  gem 'unicorn'
end
