json.array! @reasons do |reason|
  json.phrase reason.name.split(" - ")[1]
  if @feedback_stats.present?
    json.feedback_counts @feedback_stats[reason.id]
  end
end
