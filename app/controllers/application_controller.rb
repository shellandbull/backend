class ApplicationController < ActionController::Base
  JSON_API_REQUIRED_REQUEST_HEADER = "application/vnd.api+json"
  BAD_REQUEST = -> do
    render nothing: true, status: 400
  end
  NOT_FOUND = -> do
    head :not_found
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :check_request_headers!


  rescue_from ActiveRecord::RecordNotFound, &NOT_FOUND
  rescue_from ActionController::BadRequest, &BAD_REQUEST
  rescue_from ActionController::ParameterMissing, &BAD_REQUEST

  def authenticate_user!
    return if current_user

    if doorkeeper_token
      Thread.current[:current_user] = User.find(doorkeeper_token.resource_owner_id)
    else
      head :forbidden
    end
  end

  private

  def check_request_headers!
    return if request.headers["Content-Type"] == JSON_API_REQUIRED_REQUEST_HEADER
    fail ActionController::BadRequest
  end

  def serialize(resource:, options: {})
    JSONAPI::Serializer.serialize(resource, options)
  end

  def current_user
    @current_user ||= authenticate_user!
  end
end
