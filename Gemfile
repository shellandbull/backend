source "https://rubygems.org"

ruby "2.2.3"

gem "rails", ">= 5.0.0.beta3", "< 5.1"
gem "pg", "~> 0.18"
gem "puma"
gem "oj"
gem "redis", "~> 3.0"
gem "bcrypt", "~> 3.1.7"

# https://github.com/doorkeeper-gem/doorkeeper/issues/742
gem "doorkeeper", "4.0.0.rc2"
gem "jsonapi-serializers"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
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
