class Appointment < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :client
  belongs_to :bill
  belongs_to :employee
end
