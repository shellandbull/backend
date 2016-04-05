class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound do
    head :not_found
  end

  def authenticate_user!
    return if current_user

    if doorkeeper_token
      Thread.current[:current_user] = User.find(doorkeeper_token.resource_owner_id)
    end

    head :forbidden
  end

  private

  def current_user
    @current_user ||= authenticate_user!
  end
end
