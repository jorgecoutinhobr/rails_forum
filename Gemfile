source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

# added by me
gem "devise"
gem "image_processing", "~> 1.2"
gem 'inline_svg'
gem 'acts_as_votable'
gem "validate_url"
gem "sidekiq"
gem 'pg_search'
gem 'friendly_id', '~> 5.5.0'
gem 'stripe'


group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  # add by me
  gem "awesome_print"
  gem "pry-rails"
  gem "faker"
  gem 'dotenv'
end

group :development do
  gem "web-console"
  gem "letter_opener"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
