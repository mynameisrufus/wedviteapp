source 'http://rubygems.org'

ruby '2.2.2'

gem 'rails', '~> 4.1.7'

gem 'pg'
gem 'puma',                   '~> 2.10'

# User auth
gem 'devise',                 '~> 3.4'
gem 'cancan',                 '~> 1.6'
gem 'omniauth',               '~> 1.2.2'
gem 'oauth2',                 '~> 1.0.0'
gem 'omniauth-facebook',      '~> 2.0'

gem 'kaminari',               '~> 0.16.1'
gem 'sorted',                 '~> 1.0.1'
gem 'redcarpet',              '~> 2.1.1'
gem 'liquid',                 '~> 2.3.0'
gem 'ri_cal',                 '~> 0.8.8'
gem 'rails_admin',            '~> 0.6.5'
gem 'friendly_id',            '~> 5.1.0'

gem 'paperclip',              '~> 4.2'
gem 'fog-aws'
gem 'ffaker',                 '~> 1.14'
gem 'exception_notification', '~> 2.6'

gem 'sendgrid-rails',         '~> 2.0'

# Validation of stationery markup
gem 'nokogiri',               '~> 1.6'

# Generation of invitations in PDF format.
gem 'pdfkit',                 '~> 0.5.2'
gem 'wkhtmltopdf-binary',     '~> 0.9.9.1'

# Preview emails.
# https://rubygems.org/gems/mail_view
# https://github.com/37signals/mail_view
gem 'mail_view',            '~> 1.0.3'

gem 'jquery-rails',         '~> 3.0'

gem 'sass-rails',           '~> 4.0'
gem 'bootstrap-sass',       '~> 2.1.0'

gem 'uglifier',             '>= 1.0.3'

group :development, :test do
  gem 'rspec-rails',          '~> 3.1'
  gem 'machinist',            '~> 2.0'
  gem 'database_cleaner'
  gem 'awesome_print'

  gem 'capybara'

  gem 'launchy'
  gem 'pry',                  '~> 0.9'
end

group :test do
  gem 'webmock',              '~> 1.8'
end

group :development do
  gem 'guard-rspec'

  # live reload for browser
  # FIXME gem install error
  # gem 'guard-livereload'

  # file system event gems
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-fchange', require: false

  # silence asset logging and asset get requests
  gem 'quiet_assets'
end
