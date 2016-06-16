class Company < ActiveRecord::Base
	has_many :clients
	has_many :employees
	has_many :calendars
	def to_s
		name
	end
end
