json.array!(@messages) do |message|
  json.extract! message, :id, :body, :user_id, :topic_id
end