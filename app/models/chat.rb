class Chat < ActiveRecord::Base
  validates :users_id, length: { minimum: 2 }
  validates :name, presence: true
  after_save :create_status

  has_many :messages
  has_many :user, through: :messages


  def create_status
    self.users_id.each { |id| User.find(id.to_i).status.new(chat_id: self.id, last_readed: 0).save }
  end
end
