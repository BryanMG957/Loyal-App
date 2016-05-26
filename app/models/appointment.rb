class Appointment < ActiveRecord::Base
  validates :start_time, presence: true
  belongs_to :calendar
  belongs_to :client
  belongs_to :bill
  belongs_to :employee
end
