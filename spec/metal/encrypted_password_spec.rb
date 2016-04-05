require "spec_helper"
require "ostruct"
RSpec.describe Metal::EncryptedPassword, type: :utils do
  subject do
    OpenStruct.new.tap do |obj|
      obj.extend(described_class)
      obj.password = "foobar"
    end
  end

  describe "#password" do
    it "assigns @password" do
      expect(subject.password).to be_a(String)
    end
  end
end
