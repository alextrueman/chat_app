class UserSerializer < BaseSerializer
  def attributes
    {
      name: @object.name,
      messages_count: @object.messages.count
    }
  end
end
