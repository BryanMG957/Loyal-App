class Appointment < ActiveRecord::Base
  validates :start_time, presence: true
  belongs_to :calendar
  belongs_to :client
  belongs_to :bill
  belongs_to :employee
  belongs_to :service_type

  def self.by_client_id(client_id)
    where(client_id: client_id).where.not(id: nil)
  end

  def self.billable_appts(company_id)
    joins(:calendar).where("appointments.start_time < '#{Time.now.to_s}' AND appointments.bill_id IS NULL AND calendars.company_id = #{company_id}").order(:start_time)
  end

  def service_type
    serv_type = ServiceType.find_by(id: self.service.to_i)
    if serv_type.nil?
      return ServiceType.new(name: "Default")
    else
      return serv_type
    end
  end
end
