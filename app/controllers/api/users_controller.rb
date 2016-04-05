class Api::UsersController < ApplicationController
  def index
    @users = scope.find(params[:ids])
    render json: serialize(resource: @users, options: { is_collection: true })
  end

  def show
    @user = scope.find(params[:id])
    render json: serialize(resource: @user)
  end

  private

  def scope
    User
  end
end
