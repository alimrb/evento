json.array!(@events) do |event|
  json.extract! event, :id, :title, :venue, :starttime, :people, :pic
  json.url event_url(event, format: :json)
end
