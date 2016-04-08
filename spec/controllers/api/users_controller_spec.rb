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

  describe "POST /api/users" do
    context "with valid parameters" do
      let(:email) { "foo@bar.com" }
      let(:password) { "password12345" }
      let(:payload) do
        {
          data: {
            attributes: {
              email: email,
              password: password,
              password_confirmation: password
            },
            type: "users"
          }
        }
      end

      it "201 - Created" do
        post :create, params: payload
        expect(response.status).to eq(201)
      end

      it "creates a user" do
        expect { post :create, params: payload }.to change { User.count }.from(0).to(1)
      end
    end

    context "with invalid parameters" do
      let(:payload) do
        {
          data: {
            attributes: {
              email: "foo@?@.com",
              password: "123",
              password_confirmation: "123456"
            },
            type: "users"
          }
        }
      end

      before do
        post :create, params: payload
      end

      it "422 - Unprocessable entity" do
        expect(response.status).to eq(422)
      end

      it "returns errors" do
        expect(json_body.key?(:errors)).to be_truthy
        expect(json_body[:errors][:password_confirmation]).not_to be_empty
      end
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
