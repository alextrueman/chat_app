class Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :user

  validates :chat_id, presence: true
  validates :body, presence: true

  def self.unread
    binding.pry
  end

end
