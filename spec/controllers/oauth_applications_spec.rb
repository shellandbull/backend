require "rails_helper"

RSpec.describe Api::OauthApplicationsController, type: :controller do
  let(:token) { double(:token, acceptable?: true) }
  let(:user) { build(:user) }
  let(:oauth_application_name) { "Chrome Web broswer" }
  let(:oauth_application) do
    build(:oauth_application, name: oauth_application_name)
  end
  before do
    allow(controller).to receive(:check_request_headers!) { nil }
  end

  describe "GET api/oauth_applications" do
    context "without authentication" do
      before do
        get :index
      end

      it "401 - Unauthorized" do
        expect(response.status).to eq(401)
      end
    end

    context "with authentication" do
      before do
        allow(controller).to receive(:doorkeeper_token) { token }
        allow(controller).to receive(:current_user) { user }
        get :index
      end

      it "200 - Ok" do
        expect(response.status).to eq(200)
      end

      it "returns that users oauth applications" do
        # expect(r)
      end
    end
  end

  describe "GET api/oauth_applications/:id" do
    context "without authentication" do
      before do
        get :show, params: { id: 1 }
      end

      it "401 - Unauthorized" do
        expect(response.status).to eq(401)
      end
    end

    context "with authentication" do
      let(:parsed_oauth_application) do
        json_body.fetch("data")
      end
      before do
        allow(controller).to receive(:doorkeeper_token) { token }
        allow(controller).to receive(:current_user) { user }
        allow(controller.send(:scope)).to receive(:find).and_return(oauth_application)
        get :show, params: { id: 1 }
      end

      it "200 - Ok" do
        expect(response.status).to eq(200)
      end

      it "returns a serialized oauth application" do
        expect(parsed_oauth_application["type"]).to eq("oauth-applications")
        expect(parsed_oauth_application["attributes"]["name"]).to eq(oauth_application_name)
      end
    end
  end

  describe "POST api/oauth_applications" do
    context "with valid parameters" do
    end

    context "without valid parameters" do
    end
  end
end
