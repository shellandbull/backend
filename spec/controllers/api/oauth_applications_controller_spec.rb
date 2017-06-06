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
        expect(json_body.fetch(:data)).to be_empty
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
        allow(OauthApplication).to receive(:find).and_return(oauth_application)
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
      let!(:user) { create(:user) }
      let(:params) do
        {
          data: {
            type: "oauth-applications",
            attributes: {
              name: oauth_application_name,
              "redirect-uri": "https://localhost:4200/"
            },
            relationships: {
              owner: {
                data: {
                  type: "users",
                  id: user.id
                }
              }
            }
          }
        }
      end

      before do
        post :create, params: params
      end

      it "201 - Created" do
        expect(response.status).to eq(201)
      end

      it "returns the serialized oauth-application" do
        payload = json_body.fetch(:data)
        expect(payload.fetch(:attributes).fetch(:name)).to eq(oauth_application_name)
      end
    end

    context "without valid parameters" do
      let(:invalid_params) do
        {
          data: {
            type: "oauth-applications",
            attributes: {
              name: nil
              },
            relationships: {
              owner: {
                data: {
                  id: 100
                }
              }
            }
          }
        }
      end
      before do
        post :create, params: invalid_params
      end

      it "422 - Unprocessable entity" do
        expect(response.status).to eq(422)
      end

      it "Responds with errors" do
        errors = json_body.fetch(:errors)
        expect(errors.fetch(:name)).not_to be_empty
        expect(errors.fetch(:redirect_uri)).not_to be_empty
        expect(errors.fetch(:owner)).not_to be_empty
      end
    end
  end
end
