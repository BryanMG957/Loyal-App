json.array!(@payments) do |payment|
  json.extract! payment, :id, :date_received, :amount, :type, :ref, :client_id
  json.url payment_url(payment, format: :json)
end
