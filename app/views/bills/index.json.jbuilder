json.array!(@bills) do |bill|
  json.extract! bill, :id, :total_amount, :paid_amount, :date_billed, :date_paid, :discount, :client_id
  json.url bill_url(bill, format: :json)
end
