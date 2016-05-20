json.array!(@calendars) do |calendar|
  json.extract! calendar, :id, :name, :apitype, :server_incoming, :server_outgoing, :username, 
  json.url calendar_url(calendar, format: :json)
end
