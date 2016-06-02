source 'https://rubygems.org'

# Calendar display gems
gem 'fullcalendar-rails'
gem 'momentjs-rails'
gem 'bootstrap-datepicker-rails'

gem 'bootstrap-sass'
gem 'normalize-rails'
#Dependencies of Auth0
gem 'omniauth', '~> 1.3'
gem 'omniauth-auth0', '~> 1.4'

# Runtime dependencies of caldav-icloud
gem 'builder'
gem 'icalendar', '1.5.4'
gem 'net-http-digest_auth'
gem 'uuid'

# Development dependencies of caldav-icloud
gem 'fakeweb'
gem 'rspec'
gem 'caldav-icloud'
gem 'faker'
gem 'nokogiri'

# CookieOverflow fix
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
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
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :development2, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'hirb'
  gem 'rspec-rails'
  gem 'capybara'
  # gem 'capybara-webkit'
  gem 'selenium-webdriver'
end

group :development, :development2 do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
