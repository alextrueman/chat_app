class Api::V1::MessagesController < ApplicationController
  before_action :authenticate
  before_action :set_message

  def index
    render json: @user.messages.map { |message| MessagesSerializer.new(message).attributes } , status: 200
  end

  def unreaded
    render json: @user.unreaded_messages.map { |message| MessagesSerializer.new(message).attributes }
  end

  def create
    message = Message.new(message_params)
    if Chat.find(params[:chat_id]).users_id.include?(@user.id.to_s)
      if message.save
        render json: message, status: 200
      else
        render json: { status: 500 }
      end
    else
      render json: { error: "User not included to this chat" }
    end
  end

  private
  def message_params
    params.merge(user_id: @user.id).permit(:body, :chat_id, :user_id)
  end

  def set_message
    @message = Message.where(chat_id: params[:chat_id])
  end
end
