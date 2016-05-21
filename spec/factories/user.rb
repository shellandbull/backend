FactoryGirl.define do
  factory :user do
    email { "user-#{SecureRandom.hex(3)}@foo.com" }
    password "foobar12345"
  end
end
