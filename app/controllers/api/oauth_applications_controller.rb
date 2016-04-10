class Api::OauthApplicationsController < ApplicationController
  before_filter :doorkeeper_authorize!, except: [:create]
  def index
    @oauth_applications = scope
    render json: serialize(resource: @oauth_applications, options: { is_collection: true })
  end

  def show
    @oauth_application = scope.find(params[:id])
    render json: serialize(resource: @oauth_application)
  end

  def create
    fail NotImplementedError
  end

  private

  def scope
    current_user.oauth_applications
  end
end
