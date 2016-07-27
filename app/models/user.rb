class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :messages
  has_many :status

  before_create :generate_access_token

  def unreaded chat_id
    Chat.find_by(id: chat_id).messages.count - self.status.find_by(chat_id: chat_id).last_readed
  end

  def unreaded_messages
    Chat.all.where('users_id @> ARRAY[?]::varchar[]', ["#{self.id.to_s}"]).to_a.map { |c| c.messages.find { |message| self.status.find_by(chat_id: c.id).last_readed < message.id }  }
  end

  private

  def generate_access_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end
end
