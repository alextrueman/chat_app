class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(name: search_params[:name])
      if user && user.authenticate(search_params[:password])
        render json: user
      else
        render json: { status: 500 }
      end
  end

  private

  def search_params
    params.require(:user).permit(:name, :password)
  end
end
