class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate, except: [:create]

  def index
    render json: { users: User.all.map { |u| UserSerializer.new(u).attributes }, status: 200 }
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 200
    else
      render json: user.errors.messages, status: 500
    end
  end

  def show
    render json: UserSerializer.new(@user).attributes
  end

  def update
    if @user.update(user_params)
      render json:  @user, status: 200
    else
      render json:  {status: 500}
    end
  end

  def destroy
    if @user.destroy
      render json: {status: 200}
    else
      render json: {status: 500 }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
