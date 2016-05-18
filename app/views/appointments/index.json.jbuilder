json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :type, :start_time, :end_time, :charge, :reminder_before, :reminder_after, :status, :notes, :calendar_id, :client_id, :bill_id, :employee_id
  json.url appointment_url(appointment, format: :json)
end
