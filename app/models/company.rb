class Company < ActiveRecord::Base
  has_many :service_types
  has_many :clients
  has_many :employees
  has_many :calendars
  def to_s
    name
  end
end
