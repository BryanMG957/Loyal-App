json.array!(@clients) do |client|
  json.extract! client, :id, :first_name, :last_name, :email, :phone1, :phone2, :phone3, :phone4, :address, :notes, :company_id, :first_name_2, :last_name_2
  json.url client_url(client, format: :json)
end
