class MessagesSerializer < BaseSerializer
  def attributes 
    {
      body: @object.body,
      author: @object.user_id,
      chat_id: @object.chat_id
    }
  end
end
