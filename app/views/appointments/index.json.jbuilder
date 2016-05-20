json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :service, :start_time, :end_time, :charge, :reminder_before, :reminder_after, :status, :description, :notes, :calendar_id, :client_id, :bill_id, :employee_id
  json.url appointment_url(appointment, format: :json)
end
