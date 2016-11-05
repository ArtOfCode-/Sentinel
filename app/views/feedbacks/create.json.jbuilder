json.status "S:COMPLETE"
json.code "200"
json.data do
  json.post_id @feedback.post.id
  json.feedback_id @feedback.id
  json.feedback_type @feedback.feedback_type.short_code
  json.authorized_by @bot.name
end
