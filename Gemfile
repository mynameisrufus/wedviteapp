source 'http://rubygems.org'

gem 'rails', '3.2.8'

gem 'pg'
gem 'puma',                   '~> 1.4'

# User auth
gem 'devise',                 '~> 2.1'
gem 'cancan',                 '~> 1.6'
gem 'omniauth',               '~> 1.1'
gem 'oauth2',                 '~> 0.8'
gem 'omniauth-facebook',      '~> 1.4'

gem 'kaminari',               '~> 0.13.0'
gem 'sorted',                 '~> 0.4.2'
gem 'redcarpet',              '~> 2.1.1'
gem 'liquid',                 '~> 2.3.0'
gem 'ri_cal',                 '~> 0.8.8'
gem 'rails_admin',            '~> 0.0.5'
gem 'friendly_id',            '~> 4.0.1'

gem 'fog',                    '~> 1.5'
gem 'paperclip',              '~> 3.1'
gem 'ffaker',                 '~> 1.14'
gem 'exception_notification', '~> 2.6'

gem 'sendgrid-rails',         '~> 2.0'

# Validation of stationery markup
gem 'nokogiri',               '~> 1.5'

# Generation of invitations in PDF format.
gem 'pdfkit',                 '~> 0.5.2'
gem 'wkhtmltopdf-binary',     '~> 0.9.9.1'

# Preview emails.
# https://rubygems.org/gems/mail_view
gem 'mail_view',            '~> 1.0.3'

group :staging do
  # Memory profiler.
  # https://github.com/noahd1/oink
  gem 'oink'
end

group :assets do
  gem 'jquery-rails',         '~> 1.0.19'

  gem 'sass-rails',           '~> 3.2.5'
  gem 'bootstrap-sass',       '~> 2.1.0'

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

  # Code quality.
  # https://github.com/square/cane
  gem 'cane'
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
