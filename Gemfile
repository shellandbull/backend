source "https://rubygems.org"

ruby "2.3.3"

gem "rails", "5.1.1"
gem "pg", "~> 0.18"
gem "puma"
gem "oj"
gem "redis", "~> 3.0"
gem "bcrypt", "~> 3.1.7"

gem "doorkeeper", "4.2.6"
gem "jsonapi-serializers"

group :development, :test do
  gem "byebug"
  gem "pry"
end

group :test do
  gem "rspec"
  gem "rspec-rails"
  gem "database_cleaner"
  gem "factory_girl"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
