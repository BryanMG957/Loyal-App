# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Faker::Config.locale = 'en-US'
example_co = Company.create(name: "Auston's Dogs",
								description: "Your choice for local pet care",
								email: Faker::Internet.email,
								phone: Faker::PhoneNumber.phone_number,
								website: Faker::Internet.url)

Calendar.create(name: "Test Calendar", apitype: "none")

10.times do
	Client.create(first_name: Faker::Name.first_name,
								last_name: Faker::Name.last_name,
								email: Faker::Internet.email,
								phone1: Faker::PhoneNumber.phone_number,
								phone2: Faker::PhoneNumber.phone_number,
								address: Faker::Address.street_address,
								company: example_co)
end

pets = ["Bailey", "Bella", "Max", "Lucy", "Charlene", "Molly",
 "Buddy", "Daisy", "Rocky", "Maggie", "Jake", "Jack", "Sophie", "Toby", "Chloe", "Kody", "Lola", "Duke", "Cooper", "Coco", "Bear"]

20.times do |n|
	Pet.create(name: pets[rand(0..pets.length)],
						 client: Client.find((n+2)/2))
end
