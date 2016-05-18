json.array!(@calendars) do |calendar|
  json.extract! calendar, :id, :name, :type, :server_incoming, :server_outgoing, :username, :password
  json.url calendar_url(calendar, format: :json)
end
