FactoryGirl.define do
  factory :service_type do
    name { Faker::Internet.slug }
    billing_display_name { Faker::Internet.slug }
    price { Random.rand(25) }
  end
end
