require "pry"
require "factory_girl"
require_relative "./json_helper"
# load lib folder for tests, even when rails is not loaded
Dir[Dir.pwd + "/lib/**"].each { |f| require(f) if f.match(/.rb/) }

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  # mocks
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include JSONHelper, type: :controller

  # factory girl
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
