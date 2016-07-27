class ChatSerializer < BaseSerializer
  def attributes
    {
      name: @object.name,
      user_ids: @object.users_id,
      unread_messages_count: (@user.unreaded @object.id)
    }
  end
end
