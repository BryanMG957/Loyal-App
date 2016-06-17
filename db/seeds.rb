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
another_co = Company.create(name: Faker::Company.name + " " + Faker::Company.suffix,
								description: "We " + Faker::Company.bs + ".",
								email: Faker::Internet.email,
								phone: Faker::PhoneNumber.phone_number,
								website: Faker::Internet.url)
third_co = Company.create(name: Faker::Company.name + " " + Faker::Company.suffix,
								description: Faker::StarWars.quote,
								email: Faker::Internet.email,
								phone: Faker::PhoneNumber.phone_number,
								website: Faker::Internet.url)
Calendar.create(name: "Test Calendar", apitype: "none", color: "#9999FF", company: example_co)
Calendar.create(name: "Test Calendar 2", apitype: "none", color: "#ff9999", company: another_co)
25.times do |i|
	if (i < 15)
		company = example_co
	else
		company = another_co
	end
	Client.create(first_name: Faker::Name.first_name,
								last_name: Faker::Name.last_name,
								email: Faker::Internet.email,
								phone1: Faker::PhoneNumber.phone_number,
								phone2: Faker::PhoneNumber.phone_number,
								address: Faker::Address.street_address,
								company: company)
end

pets = ["Bailey", "Bella", "Max", "Lucy", "Charlene", "Molly",
 "Buddy", "Daisy", "Rocky", "Maggie", "Jake", "Jack", "Sophie", "Toby", "Chloe", "Kody", "Lola", "Duke", "Cooper", "Coco", "Bear"]

50.times do |n|
	Pet.create(name: pets[rand(0..pets.length)],
						 client: Client.find((n+2)/2))
end
