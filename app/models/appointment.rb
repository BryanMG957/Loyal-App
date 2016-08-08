class Appointment < ActiveRecord::Base
  validates :start_time, presence: true
  belongs_to :calendar
  belongs_to :client
  belongs_to :bill
  belongs_to :employee
  belongs_to :service_type
  def service_type
    begin
      ServiceType.find_by(id: self.service.to_i)
    end
  end
end
