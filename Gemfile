source 'http://rubygems.org'

gem 'rails', '3.2.6'

gem 'pg'
gem 'puma',                   '~> 1.4'

gem 'devise',                 '~> 2.1'
gem 'cancan',                 '~> 1.6'
gem 'kaminari',               '~> 0.13.0'
gem 'sorted',                 '~> 0.4.2'
gem 'redcarpet',              '~> 2.1.1'
gem 'liquid',                 '~> 2.3.0'
gem 'ri_cal',                 '~> 0.8.8'
gem 'rails_admin', git: 'https://github.com/mynameisrufus/rails_admin.git', ref: '5c763c9c3d5f979e6a5f5ebf2ea36cd5f2597f91'
gem 'friendly_id',            '~> 4.0.1'

gem 'aws-sdk',                '~> 1.5'
gem 'paperclip',              '~> 3.0'
gem 'ffaker',                 '~> 1.14'
gem 'exception_notification', '~> 2.6'

# Validation of stationery markup
gem 'nokogiri',               '~> 1.5'

# Generation of invitations in PDF format.
gem 'pdfkit',                 '~> 0.5.2'
gem 'wkhtmltopdf-binary',     '~> 0.9.9.1'

group :assets do
  gem 'jquery-rails',         '~> 1.0.19'
  gem 'less-rails-bootstrap', '~> 2.0'

  gem 'coffee-rails',         '~> 3.2.2'
  gem 'uglifier',             '>= 1.0.3'
  gem 'therubyracer',         '~> 0.10'
end

group :development, :test do
  gem 'rspec-rails',          '~> 2.10'
  gem 'machinist',            '~> 2.0'
  gem 'database_cleaner'
  gem 'awesome_print'
  gem 'steak',                '~> 2.0.0'
  gem 'launchy'
  gem 'heroku'
  gem 'pry',                  '~> 0.9'
end

group :test do
  gem 'webmock',              '~> 1.8'
end

group :development do
  gem 'guard-rspec'

  # live reload for browser
  gem 'guard-livereload'

  # file system event gems
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-fchange', require: false

  # growl notify
  gem 'ruby_gntp'

  # silence asset logging and asset get requests
  gem 'quiet_assets'
end
