FactoryGirl.define do
  factory :client do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone1 { Faker::PhoneNumber.phone_number }
    phone2 { Faker::PhoneNumber.phone_number }
    address {  Faker::Address.street_address }
  end
end
