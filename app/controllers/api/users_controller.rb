class Api::UsersController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:create]
  before_action :authenticate_user!, except: [:create]

  def index
  end

  def show
  end

  def create
  end

  private

  def user_params
  end
end
