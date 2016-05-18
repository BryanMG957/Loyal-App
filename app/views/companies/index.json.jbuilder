json.array!(@companies) do |company|
  json.extract! company, :id, :name, :email, :phone, :website, :description
  json.url company_url(company, format: :json)
end
