class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  respond_to :json


  private
  def authenticate
    @user = User.find_by(auth_token: params[:auth_token])
    if @user.nil?
      render json: { status: 500 }
    end
  end
end
