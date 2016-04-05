ENV["RAILS_ENV"] ||= 'test'
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "database_cleaner"
# Add additional requires below this line. Rails is not loaded until this point!

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
