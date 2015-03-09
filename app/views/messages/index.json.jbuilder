json.array!(@messages) do |message|
  json.extract! message, :id, :from_user_id, :to_user_id, :parent_message_id, :subject, :message, :item_id, :unread, :folder_id
  json.url message_url(message, format: :json)
end
