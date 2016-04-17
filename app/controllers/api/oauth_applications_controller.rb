class Api::OauthApplicationsController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:create]
  def index
    @oauth_applications = scope
    render json: serialize(resource: @oauth_applications, options: { is_collection: true })
  end

  def show
    @oauth_application = scope.find(params[:id])
    render json: serialize(resource: @oauth_application)
  end

  def create
    @oauth_application = OauthApplication.new(oauth_application_params)
    if @oauth_application.save
      render json: serialize(resource: @oauth_application), status: :created
    else
      render json: { errors: @oauth_application.errors }, status: :unprocessable_entity
    end
  end

  private

  def oauth_application_params
    @oauth_application_params ||= begin
      data = params.require(:data)
      hash                 = data.require(:attributes).permit(:name, :"redirect-uri")
      hash["redirect_uri"] = hash.delete(:"redirect-uri")
      hash["owner_id"]     = data.require(:relationships).require(:owner).require(:data).require(:id)
      hash
    end
  end

  def scope
    current_user.oauth_applications
  end
end
