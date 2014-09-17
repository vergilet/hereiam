json.array!(@topics) do |topic|
  json.extract! topic, :id, :latitude, :longitude, :address, :description, :title
  json.url topic_url(topic, format: :json)
end
