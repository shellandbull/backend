require "rails_helper"

RSpec.describe Api::UsersController, type: :controller do
  let(:body) { JSON.parse(response.body).with_indifferent_access }

  describe "#index" do
    let(:users) { [build(:user), build(:user)] }
    before do
      allow(controller.send(:scope)).to receive(:find) { users }
      get :index, params: { ids: [1,2] }
    end

    it "200 - OK" do
      expect(response.status).to eq(200)
    end

    it "returns a collection of users" do
      expect(body.fetch(:data).length).to eq(users.length)
    end
  end

  describe "#show" do
    let(:email) { "foo@bar.com" }
    let(:user) { build(:user, email: email) }

    before do
      allow(controller.send(:scope)).to receive(:find) { user }
      get :show, params: { id: 1 }
    end

    it "200 - OK" do
      expect(response.status).to eq(200)
    end

    it "returns a user's attributes in the payload" do
      expect(body.fetch(:data).fetch(:attributes).fetch(:email)).to eq(email)
    end
  end
end
