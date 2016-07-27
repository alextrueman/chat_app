class Api::V1::ChatsController < ApplicationController
  before_action :authenticate
  before_action :set_chat, only: [:show, :edit, :destroy, :update]

  def index
    render json: Chat.select { |c| c.users_id.include? @user.id.to_s }.map { |chat| ChatSerializer.new(chat, @user).attributes }
  end

  def show
    render json: ChatSerializer.new(@chat, @user).attributes
  end

  def read_all
    @user.status.find_by(chat_id: params[:chat_id]).update!(last_readed: Chat.find(params[:chat_id]).messages.last.id)
    render json: { status: 200 }
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      render json: @chat
    else
      render json: @chat.errors.messages
    end
  end

  def destroy
  end

  def update
    @chat = Chat.new(chat_params)
    if @chat.save
      render json: @chat, status: :updated
    else
      render json: @chat.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.permit(:name, users_id: [])
  end

end
