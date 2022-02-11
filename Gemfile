source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 6.0.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'curb', '= 0.9.7'
gem 'dry-initializer'
gem 'tram-page'

group :development, :test do
  gem 'byebug'
  gem 'pry-byebug'
  gem 'dotenv-rails'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'rubocop-performance'
  gem 'rspec_junit_formatter'
  gem 'webmock'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'database_cleaner'
end
