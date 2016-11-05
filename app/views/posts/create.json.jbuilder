json.status "S:COMPLETE"
json.code "200"
json.data do
  json.post_id @post.id
  json.created_at @post.created_at
  json.authorized_by @bot.name
end
