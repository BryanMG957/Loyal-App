FactoryGirl.define do
  factory :pet do
    name ["Bailey", "Bella", "Max", "Lucy", "Charlene", "Molly",
          "Buddy", "Daisy", "Rocky", "Maggie", "Jake", "Jack", "Sophie", "Toby", "Chloe", "Kody", "Lola", "Duke", "Cooper", "Coco", "Bear"].sample
    notes Faker::Lorem.sentence
  end
end
