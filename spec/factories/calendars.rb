FactoryGirl.define do
  factory :calendar do
    name { Faker::Name.first_name + "'s Calendar" }
    apitype "none"
    color { Faker::Color.hex_color }
  end
end
