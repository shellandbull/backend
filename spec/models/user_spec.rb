require "rails_helper"

RSpec.describe User, type: :model do
  let(:email) { "foo@bar.com" }
  let(:password) { "mario123456" }
  subject do
    described_class.new(email: email,
                        password: password,
                        password_confirmation: password)
  end

  describe "attributes" do
    it "#email" do
      expect(subject.email).to eq(email)
    end

    it "#password" do
      expect(subject.password).to eq(password)
    end
  end
end
