require "rails_helper"

RSpec.describe Api::UsersController, type: :controller do
  describe "GET /api/users" do
    let(:users) { [build(:user), build(:user)] }
    before do
      allow(controller.send(:scope)).to receive(:find) { users }
      get :index, params: { ids: [1,2] }
    end

    it "200 - OK" do
      expect(response.status).to eq(200)
    end

    it "returns a collection of users" do
      expect(json_body.fetch(:data).length).to eq(users.length)
    end
  end

  describe "GET /api/users/:id" do
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
      expect(json_body.fetch(:data).fetch(:attributes).fetch(:email)).to eq(email)
    end
  end
end
