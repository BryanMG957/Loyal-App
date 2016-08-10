class Appointment < ActiveRecord::Base
  validates :start_time, presence: true
  belongs_to :calendar
  belongs_to :client
  belongs_to :bill
  belongs_to :employee
  belongs_to :service_type
  def service_type
    serv_type = ServiceType.find_by(id: self.service.to_i)
    if serv_type.nil?
      return ServiceType.new(name: "Default")
    else
      return serv_type
    end
  end
end
