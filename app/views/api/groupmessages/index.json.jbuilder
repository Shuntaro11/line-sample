json.array! @messages do |message|
  json.content message.content
  json.image message.image.url
  json.created_at message.created_at.strftime('%m/%d %H:%M')
  json.user_name message.user.name
  json.user_image message.user.image.url
  json.id message.id
end
