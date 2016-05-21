class Api::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:update]

  def index
    @users = scope.find(params[:ids])
    render json: serialize(resource: @users, options: { is_collection: true })
  end

  def show
    @user = scope.find(params[:id])
    render json: serialize(resource: @user)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: serialize(resource: @user), status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params.require(:id))
    return head(:forbidden) unless @user.id == current_user.id
    if @user.update_attributes(user_params)
      render json: serialize(resource: @user)
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:data).require(:attributes).permit(:email, :password, :password_confirmation)
  end

  def scope
    User
  end
end
