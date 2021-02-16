source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
#gem 'rails', '~> 6.1.0'

# For now, we will not use some of the fancier features of rails. 

#gem 'actioncable', '~> 6.1.0'
#gem 'actionmailbox', '~> 6.1.0'
#gem 'actionmailer', '~> 6.1.0'
gem 'actionpack', '~> 6.1.0'
#gem 'actiontext', '~> 6.1.0'
gem 'actionview', '~> 6.1.0'
#gem 'activejob', '~> 6.1.0'
gem 'activemodel', '~> 6.1.0'
gem 'activerecord', '~> 6.1.0'
#gem 'activestorage', '~> 6.1.0'
gem 'activesupport', '~> 6.1.0'
gem 'bundler', '>= 1.15.0'
gem 'railties', '~> 6.1.0'

# exclude sprockets as we are using webpacker instead
# gem 'sprockets-rails', '>= 2.0.0'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
# excluding because we are using webpacker instead
# gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'pagy' # pagination
gem 'cancancan' # authorization

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# BBRedCloth is the Textile/BBCode generator
gem 'BBRedCloth', '>= 0.9.0.alpha1', require: 'redcloth'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '>= 3.26'
  # gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  # gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
