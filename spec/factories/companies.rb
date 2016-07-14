FactoryGirl.define do
  factory :company do
    name { Faker::Company.name + " " + Faker::Company.suffix }
		description { Faker::StarWars.quote }
    email { Faker::Internet.email }
		phone { Faker::PhoneNumber.phone_number }
		website { Faker::Internet.url }
  end
end
